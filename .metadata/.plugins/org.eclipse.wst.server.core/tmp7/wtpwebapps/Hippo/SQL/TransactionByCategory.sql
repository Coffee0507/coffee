start transaction isolation level serializable;
--重複するデータを削除する
select delete_rows_by_category();
--親テーブルにインサートして、そのIDを取得
drop table if exists by_category_id;
CREATE TEMPORARY TABLE IF NOT EXISTS by_category_id AS select by_category_id();
--子テーブル(分類別)にインサート
drop table if exists temp_category_tbl;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_category_tbl(category_order_num serial primary key, category_name text, category_target_value bigint);
select by_category_category();
--子テーブル(担当別)にインサート
drop table if exists temp_sales_staff_tbl;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_sales_staff_tbl(sales_staff_order_num serial primary key, sales_staff_name text, sales_staff_target_value bigint);
select by_category_sales_staff();
--子テーブル(来年度案件)にインサート
drop table if exists temp_next_year_tbl;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_next_year_tbl(next_year_order_num serial primary key, sales_staff_name text, next_year_target_value bigint);
select by_category_next_year();
--一時テーブルを削除
drop table by_category_id;
drop table temp_category_tbl;
drop table temp_sales_staff_tbl;
drop table temp_next_year_tbl;

COMMIT;