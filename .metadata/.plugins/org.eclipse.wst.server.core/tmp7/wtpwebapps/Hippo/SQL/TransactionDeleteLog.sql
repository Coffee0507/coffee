start transaction isolation level serializable;
delete from log_tbl where created_at::DATE <= (now()::DATE - 10);
delete from syslog_tbl where created_at::DATE <= (now()::DATE - 10);
commit;