start transaction isolation level serializable;
--�d������f�[�^���폜����
select delete_rows_revenue_by_month();
--�e�e�[�u���ɃC���T�[�g
drop table if exists revenue_by_month_id;
CREATE TEMPORARY TABLE IF NOT EXISTS revenue_by_month_id AS select revenue_by_month_id();
--�q�e�[�u���ɃC���T�[�g
select foreign_revenue_by_month();
--�ꎞ�e�[�u�����폜
drop table revenue_by_month_id;

COMMIT;