start transaction isolation level serializable;
--�d������f�[�^���폜����
select delete_rows_ttl_by_month();
--�e�e�[�u���ɃC���T�[�g
drop table if exists ttl_by_month_id;
CREATE TEMPORARY TABLE IF NOT EXISTS ttl_by_month_id AS select ttl_by_month_id();
--�q�e�[�u���ɃC���T�[�g
select foreign_ttl_by_month();
--�ꎞ�e�[�u�����폜
drop table ttl_by_month_id;

COMMIT;