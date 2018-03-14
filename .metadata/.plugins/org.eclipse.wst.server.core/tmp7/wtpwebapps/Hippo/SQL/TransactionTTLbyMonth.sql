start transaction isolation level serializable;
--重複するデータを削除する
select delete_rows_ttl_by_month();
--親テーブルにインサート
drop table if exists ttl_by_month_id;
CREATE TEMPORARY TABLE IF NOT EXISTS ttl_by_month_id AS select ttl_by_month_id();
--子テーブルにインサート
select foreign_ttl_by_month();
--一時テーブルを削除
drop table ttl_by_month_id;

COMMIT;