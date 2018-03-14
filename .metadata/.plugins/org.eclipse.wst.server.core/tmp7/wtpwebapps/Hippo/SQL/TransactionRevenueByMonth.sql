start transaction isolation level serializable;
--重複するデータを削除する
select delete_rows_revenue_by_month();
--親テーブルにインサート
drop table if exists revenue_by_month_id;
CREATE TEMPORARY TABLE IF NOT EXISTS revenue_by_month_id AS select revenue_by_month_id();
--子テーブルにインサート
select foreign_revenue_by_month();
--一時テーブルを削除
drop table revenue_by_month_id;

COMMIT;