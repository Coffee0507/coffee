--delete from log_tbl where created_at < (now() - interval '1 months');

-- 30���O�̃f�[�^���폜
delete from log_tbl where created_at <= (now()::DATE - 30);
-- 30���O�̃f�[�^�͍폜���Ȃ�
delete from log_tbl where created_at < (now()::DATE - 30);
--��Q���ƁAtimestamp�̎��Ԃ��l�����Čv�Z���Ă��܂��̂ŕύX(timestamp��date�^�ɃL���X�g)
delete from log_tbl where created_at::DATE <= (now()::DATE - 30);
delete from syslog_tbl where created_at::DATE <= (now()::DATE - 30);

--�g�����U�N�V����
start transaction isolation level serializable;
delete from log_tbl where created_at::DATE <= (now()::DATE - 30);
delete from syslog_tbl where created_at::DATE <= (now()::DATE - 30);
commit;