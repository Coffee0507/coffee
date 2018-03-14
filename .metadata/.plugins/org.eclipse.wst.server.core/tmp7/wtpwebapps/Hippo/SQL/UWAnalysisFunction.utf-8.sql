--8/29修正
--同じ集計日の場合は、親テーブルのidを更新せず、同じものを使用する。子テーブルはdeleteしてinsertする

--bigintの範囲を超える数値をbigintの最大値にまるめる関数
create or replace function cast_to_bigint(numeric) returns bigint as $$
begin
    return cast($1 as bigint);
exception
    when numeric_value_out_of_range then
        return 9223372036854775807;
end;
$$ language plpgsql immutable
;

--総計分類別
--集計日が重複するデータを子テーブルから削除する
create or replace function delete_rows_by_category() 
    returns void as 
    $$
        declare
            result_count int; --重複行の数
            result_id bigint; --重複行の親テーブルid
        begin
            --重複行の数を取得
            select into result_count count(aggregate_date) from total_tbl where aggregate_date = current_date;
            
            if result_count != 0 then --重複行があったとき
               select into result_id id from total_tbl where aggregate_date = current_date;
               delete from total_by_cat_tbl where total_tbl_id = result_id;
               delete from total_by_sales_staff_tbl where total_tbl_id = result_id;
               delete from next_year_orders_by_sales_staff_tbl where total_tbl_id = result_id;
            end if;
        end
    $$
    LANGUAGE plpgsql
;
--親テーブルに集計日が重複するデータがあるときは、そのIDを取得、重複するデータがないときは、インサートしてそのIDを取得する関数
create or replace function by_category_id() 
    returns bigint as 
    $$
        declare
        	result_count int; --重複行の数
            table_id bigint;
        begin
	        --重複行の数を取得
            select into result_count count(aggregate_date) from total_tbl where aggregate_date = current_date;
	        
            if result_count != 0 then --重複行があったとき
            	update total_tbl set changed_at = current_timestamp 
            	where aggregate_date = current_date 
            	returning total_tbl.id into table_id; 
            	
            else --重複行がないとき
            	INSERT INTO total_tbl(aggregate_date, created_at) 
            	VALUES(current_date, current_timestamp) 
            	RETURNING total_tbl.id INTO table_id;
            end if;
            
            RETURN table_id;
        end;
    $$
    LANGUAGE plpgsql
;
--子テーブルにインサート
--型
drop type if exists by_category_type;
drop type if exists temp_by_category_type;
create type by_category_type as (name text, target_value bigint);
create type temp_by_category_type as(t_order_num bigint, t_name text, t_target_value bigint);
--子テーブル：分類別
create or replace function by_category_category() 
returns void as
$$
    declare
        row_by_category_type by_category_type;
        row_temp_by_category_type temp_by_category_type;
    begin
        for row_by_category_type in (select cat_name, coalesce(target_val, 0) from cat_tbl order by id) --分類テーブルからデータをid順にデータを取得
        loop --一時テーブルで取得したデータを保持
           insert into temp_category_tbl(category_name, category_target_value) values(row_by_category_type.name, row_by_category_type.target_value);
        end loop;
        
        for row_temp_by_category_type in (select category_order_num, category_name, category_target_value from temp_category_tbl order by category_order_num)--一時テーブルのデータを1レコードずつ取得
        loop--子テーブルにデータをインサート
           insert into total_by_cat_tbl(total_tbl_id, disp_order, cat_name, target_val, total_orders, total_sales, created_at) 
           values (
               (select by_category_id from by_category_id), 
               row_temp_by_category_type.t_order_num - 1,
               row_temp_by_category_type.t_name,
               row_temp_by_category_type.t_target_value,
               (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                AND sales_status_name = '受注済' 
                AND cat_name = row_temp_by_category_type.t_name))), 
               (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                AND sales_status_name = '売上済' 
                AND cat_name = row_temp_by_category_type.t_name))), 
               current_timestamp
           );
        end loop;
        return;
    end;
$$
LANGUAGE plpgsql
;
--子テーブル：担当別
create or replace function by_category_sales_staff() 
returns void as
$$
    declare
        row_by_category_type by_category_type;
        row_temp_by_category_type temp_by_category_type;
    begin
        for row_by_category_type in (select sales_staff, coalesce(target_val, 0) from sales_staff_tbl order by id) 
        loop
           insert into temp_sales_staff_tbl(sales_staff_name, sales_staff_target_value) values(row_by_category_type.name, row_by_category_type.target_value);
        end loop;
        
        for row_temp_by_category_type in (select sales_staff_order_num, sales_staff_name, sales_staff_target_value from temp_sales_staff_tbl order by sales_staff_order_num)
        loop
           insert into total_by_sales_staff_tbl(total_tbl_id, disp_order, sales_staff, target_val, total, created_at) 
           values (
               (select by_category_id from by_category_id), 
               row_temp_by_category_type.t_order_num - 1,
               row_temp_by_category_type.t_name,
               row_temp_by_category_type.t_target_value,
               (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                AND (sales_status_name = '受注済' OR sales_status_name = '売上済') 
                AND sales_staff = row_temp_by_category_type.t_name))), 
               current_timestamp
           );
        end loop;
        return;
    end;
$$
LANGUAGE plpgsql
;
--子テーブル：来年度案件
create or replace function by_category_next_year() 
returns void as
$$
    declare
        row_by_category_type by_category_type;
        row_temp_by_category_type temp_by_category_type;
    begin
        for row_by_category_type in (select sales_staff, coalesce(next_year_target_val, 0) from sales_staff_tbl order by id) 
        loop
           insert into temp_next_year_tbl(sales_staff_name, next_year_target_value) values(row_by_category_type.name, row_by_category_type.target_value);
        end loop;
        
        for row_temp_by_category_type in (select next_year_order_num, sales_staff_name, next_year_target_value from temp_next_year_tbl order by next_year_order_num)
        loop
           insert into next_year_orders_by_sales_staff_tbl(total_tbl_id, disp_order, sales_staff, next_year_target_val, total_orders, forecast, created_at) 
           values (
               (select by_category_id from by_category_id), 
               row_temp_by_category_type.t_order_num - 1,
               row_temp_by_category_type.t_name,
               row_temp_by_category_type.t_target_value,
               (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) + 1 
                AND sales_status_name = '受注済' 
                AND sales_staff = row_temp_by_category_type.t_name))), 
                (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) + 1 
                AND sales_status_name = '見込み' 
                AND sales_staff = row_temp_by_category_type.t_name))), 
               current_timestamp
           );
        end loop;
        return;
    end;
$$
LANGUAGE plpgsql
;

--月別合計
--集計日が重複するデータを削除する
create or replace function delete_rows_ttl_by_month() 
    returns void as 
    $$
        declare
            result_count int; --重複行の数
            result_id bigint; --重複行の親テーブルid
        begin
            --重複行の数を取得
            select into result_count count(aggregate_date) from orders_and_sales_tbl where aggregate_date = current_date;
            
            if result_count != 0 then --重複行があったとき
               select into result_id id from orders_and_sales_tbl where aggregate_date = current_date;
               delete from monthly_orders_and_sales_tbl where orders_and_sales_tbl_id = result_id;
            end if;
        end
    $$
    LANGUAGE plpgsql
;

--親テーブルのidを取得する関数
create or replace function ttl_by_month_id() 
    returns bigint as 
    $$
        declare
        	result_count int; --重複行の数
          	table_id bigint;
        begin
	        --重複行の数を取得
            select into result_count count(aggregate_date) from orders_and_sales_tbl where aggregate_date = current_date;
	       
            if result_count != 0 then --重複行があったとき
            	update orders_and_sales_tbl 
            	set pre_year_orders = (SELECT cast_to_bigint from cast_to_bigint((coalesce((SELECT SUM(value_of_order) FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year_of_order, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year_of_sales FROM sales_tbl) as a WHERE fiscal_year_of_order < (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) AND fiscal_year_of_sales = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) AND (sales_status_name = '受注済' OR sales_status_name = '売上済')), 0)))), 
            		next_year_orders = (SELECT cast_to_bigint from cast_to_bigint((coalesce((SELECT SUM(value_of_order) FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year_of_order, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year_of_sales FROM sales_tbl) as a WHERE fiscal_year_of_order < (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date) ELSE date_part('year',current_date)+1 END) AND fiscal_year_of_sales = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date) ELSE date_part('year',current_date)+1 END) AND sales_status_name = '受注済'), 0)))), 
            		changed_at = current_timestamp 
            	where aggregate_date = current_date 
            	returning orders_and_sales_tbl.id INTO table_id;
            
            else --重複行がないとき
            	INSERT INTO orders_and_sales_tbl(aggregate_date, pre_year_orders, next_year_orders, created_at)
            	VALUES(current_date, 
                  (SELECT cast_to_bigint from cast_to_bigint((coalesce((SELECT SUM(value_of_order) FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year_of_order, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year_of_sales FROM sales_tbl) as a WHERE fiscal_year_of_order < (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) AND fiscal_year_of_sales = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) AND (sales_status_name = '受注済' OR sales_status_name = '売上済')), 0)))), 
                  (SELECT cast_to_bigint from cast_to_bigint((coalesce((SELECT SUM(value_of_order) FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year_of_order, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year_of_sales FROM sales_tbl) as a WHERE fiscal_year_of_order < (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date) ELSE date_part('year',current_date)+1 END) AND fiscal_year_of_sales = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date) ELSE date_part('year',current_date)+1 END) AND sales_status_name = '受注済'), 0)))), 
                  current_timestamp) 
            	RETURNING orders_and_sales_tbl.id INTO table_id;
            end if;	
            RETURN table_id;
        end;
    $$
    LANGUAGE plpgsql
;
--月ごとのデータをisnertする関数
create or replace function foreign_ttl_by_month() 
    returns void as 
    $$
        begin
            for i in 1 .. 12 loop
                insert into monthly_orders_and_sales_tbl(orders_and_sales_tbl_id, month_val, orders_total_val, sales_total_val, created_at) 
                values((select ttl_by_month_id from ttl_by_month_id), 
                        i, 
                        (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                         FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
                         WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                         AND date_part('month',date_of_orders) = i 
                         AND (sales_status_name = '受注済' OR sales_status_name = '売上済')))), 
                        (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                         FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                         WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                         AND date_part('month',date_of_sales) = i 
                         AND sales_status_name = '売上済'))), 
                        current_timestamp);
            end loop;
            return;
        end;
    $$
    LANGUAGE plpgsql
;

--総計
--集計日が重複するデータを削除する
create or replace function delete_rows_revenue_by_month() 
    returns void as 
    $$
        declare
            result_count int; --重複行の数
            result_id bigint; --重複行の親テーブルid
        begin
            --重複行の数を取得
            select into result_count count(aggregate_date) from total_amount_tbl where aggregate_date = current_date;
            
            if result_count != 0 then --重複行があったとき
               select into result_id id from total_amount_tbl where aggregate_date = current_date;
               delete from monthly_total_amount_tbl where total_amount_tbl_id = result_id;
            end if;
        end
    $$
    LANGUAGE plpgsql
;
--親テーブルにインサートしてそのIDを取得する関数
create or replace function revenue_by_month_id() 
    returns bigint as 
    $$
        declare
        	result_count int; --重複行の数
            table_id bigint;
        begin
	        --重複行の数を取得
            select into result_count count(aggregate_date) from total_amount_tbl where aggregate_date = current_date;
	        
            if result_count != 0 then --重複行があったとき
            	update total_amount_tbl set changed_at = current_timestamp 
            	where aggregate_date = current_date 
            	RETURNING total_amount_tbl.id INTO table_id;
            
            else
            	INSERT INTO total_amount_tbl(aggregate_date, created_at)
            	VALUES(current_date, current_timestamp) 
            	RETURNING total_amount_tbl.id INTO table_id;
            end if;	
            
            RETURN table_id;
        end;
    $$
    LANGUAGE plpgsql
;

--子テーブルにインサートする関数
create or replace function foreign_revenue_by_month() 
    returns void as 
    $$
        begin
            for i in 1 .. 12 loop
                insert into monthly_total_amount_tbl(total_amount_tbl_id, month_val, orders_total_val, sales_total_val, created_at) 
                values((select revenue_by_month_id from revenue_by_month_id), 
                        i, 
                        (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                         FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                         WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                         AND date_part('month',date_of_sales) = i 
                         AND sales_status_name = '受注済'))), 
                        (SELECT cast_to_bigint from cast_to_bigint((SELECT coalesce(SUM(value_of_order), 0) 
                         FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                         WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                         AND date_part('month',date_of_sales) = i 
                         AND sales_status_name = '売上済'))), 
                        current_timestamp);
            end loop;
            return;
        end;
    $$
    LANGUAGE plpgsql
;

--月別総計
--集計日が重複するデータを削除する
create or replace function delete_rows_gttl_by_month() 
    returns void as 
    $$
        declare
            result_count int; --重複行の数
            result_id bigint; --重複行の親テーブルid
        begin
            --重複行の数を取得
            select into result_count count(aggregate_date) from grand_total_orders_and_sales_tbl where aggregate_date = current_date;
            
            if result_count != 0 then --重複行があったとき
               select into result_id id from grand_total_orders_and_sales_tbl where aggregate_date = current_date;
               delete from monthly_grand_total_orders_and_sales_tbl where grand_total_orders_and_sales_tbl_id = result_id;
            end if;
        end
    $$
    LANGUAGE plpgsql
;
--親テーブルにインサート
create or replace function gttl_by_month_id() 
    returns bigint as 
    $$
        declare
        	result_count int; --重複行の数
            table_id bigint;
        begin
	        --重複行の数を取得
            select into result_count count(aggregate_date) from grand_total_orders_and_sales_tbl where aggregate_date = current_date;
            
            if result_count != 0 then --重複行があったとき
            	update grand_total_orders_and_sales_tbl 
            	set pre_year_orders = (SELECT cast_to_bigint from cast_to_bigint((coalesce((SELECT SUM(value_of_order) FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year_of_order, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year_of_sales FROM sales_tbl) as a WHERE fiscal_year_of_order < (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) AND fiscal_year_of_sales = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) AND (sales_status_name = '受注済' OR sales_status_name = '売上済')), 0)))), 
            		changed_at = current_timestamp
            	where aggregate_date = current_date 
            	RETURNING grand_total_orders_and_sales_tbl.id INTO table_id;
	        
            else
            	INSERT INTO grand_total_orders_and_sales_tbl(aggregate_date, pre_year_orders, created_at)
            	VALUES(current_date, 
                      (SELECT cast_to_bigint from cast_to_bigint((coalesce((SELECT SUM(value_of_order) FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year_of_order, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year_of_sales FROM sales_tbl) as a WHERE fiscal_year_of_order < (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) AND fiscal_year_of_sales = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) AND (sales_status_name = '受注済' OR sales_status_name = '売上済')), 0)))), 
                       current_timestamp) 
            	RETURNING grand_total_orders_and_sales_tbl.id INTO table_id;
            end if;
            
            RETURN table_id;
        end;
    $$
    LANGUAGE plpgsql
;
--月別合計値を一時テーブルにインサート
create or replace function insert_temp_ttl_by_month() 
returns void as 
$$
    declare
        month_array integer[] := '{4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3}';
        month_array_element integer;
    begin
        foreach month_array_element in array month_array loop 
            insert into temp_ttl_by_month(month, ttl_of_order, ttl_of_sales) 
            values(
                month_array_element, 
                (SELECT cast_to_bigint from cast_to_bigint((select coalesce(SUM(value_of_order), 0) 
                FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
                WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                AND date_part('month',date_of_orders) = month_array_element 
                AND (sales_status_name = '受注済' OR sales_status_name = '売上済')))), 
                (SELECT cast_to_bigint from cast_to_bigint((select coalesce(SUM(value_of_order), 0) 
                FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
                WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
                AND date_part('month',date_of_sales) = month_array_element 
                AND sales_status_name = '売上済')))
            );
            
        end loop;
        return;
    end; 
$$
LANGUAGE plpgsql
;
--子テーブルにインサート
--型
drop type if exists gttl_by_month_type;
create type gttl_by_month_type as (t_month integer, t_gttl_of_order numeric, t_gttl_of_sales numeric);
--関数
create or replace function foreign_gttl_by_month() 
returns void as
$$
    declare
        row_gttl_by_month_type gttl_by_month_type;
    begin
        for row_gttl_by_month_type in (select month, gttl_of_order, gttl_of_sales from temp_gttl_by_month) 
        loop
        if row_gttl_by_month_type.t_month != 0 then
           insert into monthly_grand_total_orders_and_sales_tbl(grand_total_orders_and_sales_tbl_id, month_val, orders_grand_total_val, sales_grand_total_val, created_at) 
           values((select gttl_by_month_id from gttl_by_month_id), 
                  row_gttl_by_month_type.t_month, 
                  (select cast_to_bigint from cast_to_bigint((row_gttl_by_month_type.t_gttl_of_order))), 
                  (select cast_to_bigint from cast_to_bigint((row_gttl_by_month_type.t_gttl_of_sales))), 
                  current_timestamp
           );
        end if;
        end loop;
      
        return;
    end;
$$
LANGUAGE plpgsql
;