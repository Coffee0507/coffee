--delete from log_tbl where created_at < (now() - interval '1 months');

-- 30日前のデータも削除
delete from log_tbl where created_at <= (now()::DATE - 30);
-- 30日前のデータは削除しない
delete from log_tbl where created_at < (now()::DATE - 30);
--上２つだと、timestampの時間も考慮して計算してしまうので変更(timestampをdate型にキャスト)
delete from log_tbl where created_at::DATE <= (now()::DATE - 30);
delete from syslog_tbl where created_at::DATE <= (now()::DATE - 30);

--トランザクション
start transaction isolation level serializable;
delete from log_tbl where created_at::DATE <= (now()::DATE - 30);
delete from syslog_tbl where created_at::DATE <= (now()::DATE - 30);
commit;