--受注月を年度表示にする
select case when date_part('month',date_of_orders) < 4 then date_part('year',date_of_orders)-1 else date_part('year',date_of_orders) end as nendo from sales_tbl;
--今年度
select case when date_part('month',current_date) < 4 then date_part('year',current_date)-1 else date_part('year',current_date) end as fiscal_year;


--集計日が重複するデータを削除
delete from orders_and_sales_tbl where exists (select * from orders_and_sales_tbl where aggregate_date = current_date);

--集計日が重複するデータがなければ親テーブルにinsert
INSERT INTO orders_and_sales_tbl(aggregate_date, pre_year_orders, next_year_orders, created_at)
SELECT current_date, 前期, 来期, current_timestamp
WHERE NOT EXISTS (SELECT aggregate_date FROM orders_and_sales_tbl WHERE aggregate_date = current_date);

--戻り値が親テーブルのidになるinsert文
INSERT INTO orders_and_sales_tbl(aggregate_date, pre_year_orders, next_year_orders, created_at)
SELECT current_date, 1000, 1000, current_timestamp
WHERE NOT EXISTS (SELECT * FROM orders_and_sales_tbl WHERE aggregate_date = current_date)
RETURNING orders_and_sales_tbl.id;

--関数を使用してinsert、親テーブルidを取得
select orders_and_sales_id();

--別合計・別総計 受注テーブル 前期分
SELECT SUM(value_of_order) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year < (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND sales_status_name = '受注済';

--別合計 受注テーブル 来期分
SELECT SUM(value_of_order) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year > (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND sales_status_name = '受注済';

--別合計 4月 受注
SELECT coalesce(SUM(value_of_order), 0) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND date_part('month',date_of_orders) = 4 
AND sales_status_name = '受注済';

--別合計 4月 売上
SELECT coalesce(SUM(value_of_order), 0) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND date_part('month',date_of_sales) = 4 
AND sales_status_name = '売上済';


--総計分類別
--分類別　受注済
SELECT coalesce(SUM(value_of_order), 0) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND sales_status_name = '受注済' 
AND cat_name = 'test00';
--分類別　売上済
SELECT coalesce(SUM(value_of_order), 0) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND sales_status_name = '売上済' 
AND cat_name = 'test00';


--月別総計
--ある集計日の4月から12月のデータ
select * from monthly_orders_and_sales_tbl where orders_and_sales_tbl_id = 16 and month_val >= 4 order by month_val;
--累計値
select month_val, orders_total_val, sales_total_val, sum(orders_total_val) over(order by month_val asc) as gttl_order, sum(sales_total_val) over (order by month_val asc) as gttl_sales 
from monthly_orders_and_sales_tbl where orders_and_sales_tbl_id = 16 and month_val >= 4 order by month_val;
--一時テーブルに4月から12月の累計データを入れる
create temporary table gttl_4to12 as 
select month_val, sum(orders_total_val) over(order by month_val asc) as gttl_order, sum(sales_total_val) over (order by month_val asc) as gttl_sales alter
from monthly_orders_and_sales_tbl 
where orders_and_sales_tbl_id = (select ttl_by_month_id from ttl_by_month_id) 
and month_val >= 4 
order by month_val;
--一時テーブルに1月から3月の累計データを入れる
create temporary table gttl_4to12 as 
select month_val, sum(orders_total_val) over(order by month_val asc) as gttl_order, sum(sales_total_val) over (order by month_val asc) as gttl_sales alter
from monthly_orders_and_sales_tbl 
where orders_and_sales_tbl_id = (select ttl_by_month_id from ttl_by_month_id) 
and month_val < 4 
order by month_val;
--4月に前期分、1月から3月に12月分のデータを足す

