start transaction isolation level serializable;
--重複するデータを削除する
select delete_rows_gttl_by_month();
--親テーブルにインサート
drop table if exists gttl_by_month_id;
CREATE TEMPORARY TABLE IF NOT EXISTS gttl_by_month_id AS select gttl_by_month_id();
--一時的に月別合計を集計
drop table if exists temp_ttl_by_month;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_ttl_by_month(num serial primary key, month integer, ttl_of_order numeric, ttl_of_sales numeric);
--前年度分データのみ一時テーブルにインサート(月を0とする)
insert into temp_ttl_by_month(month, ttl_of_order, ttl_of_sales) 
values(0, 
       (SELECT cast_to_bigint from cast_to_bigint((select pre_year_orders from grand_total_orders_and_sales_tbl where id = (select gttl_by_month_id from gttl_by_month_id)))), 
       0
      );
--月ごとの合計データをインサート
select insert_temp_ttl_by_month();
--一時的に累計表を作成する
drop table if exists temp_gttl_by_month;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_gttl_by_month as select month, sum(ttl_of_order) over(order by num) as gttl_of_order, sum(ttl_of_sales) over(order by num) as gttl_of_sales from temp_ttl_by_month order by num;
--子テーブルにインサート
select foreign_gttl_by_month();
--一時テーブルを削除
drop table gttl_by_month_id;
drop table temp_ttl_by_month;
drop table temp_gttl_by_month;

COMMIT;