start transaction isolation level serializable;
--�d������f�[�^���폜����
select delete_rows_gttl_by_month();
--�e�e�[�u���ɃC���T�[�g
drop table if exists gttl_by_month_id;
CREATE TEMPORARY TABLE IF NOT EXISTS gttl_by_month_id AS select gttl_by_month_id();
--�ꎞ�I�Ɍ��ʍ��v���W�v
drop table if exists temp_ttl_by_month;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_ttl_by_month(num serial primary key, month integer, ttl_of_order numeric, ttl_of_sales numeric);
--�O�N�x���f�[�^�݈̂ꎞ�e�[�u���ɃC���T�[�g(����0�Ƃ���)
insert into temp_ttl_by_month(month, ttl_of_order, ttl_of_sales) 
values(0, 
       (SELECT cast_to_bigint from cast_to_bigint((select pre_year_orders from grand_total_orders_and_sales_tbl where id = (select gttl_by_month_id from gttl_by_month_id)))), 
       0
      );
--�����Ƃ̍��v�f�[�^���C���T�[�g
select insert_temp_ttl_by_month();
--�ꎞ�I�ɗ݌v�\���쐬����
drop table if exists temp_gttl_by_month;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_gttl_by_month as select month, sum(ttl_of_order) over(order by num) as gttl_of_order, sum(ttl_of_sales) over(order by num) as gttl_of_sales from temp_ttl_by_month order by num;
--�q�e�[�u���ɃC���T�[�g
select foreign_gttl_by_month();
--�ꎞ�e�[�u�����폜
drop table gttl_by_month_id;
drop table temp_ttl_by_month;
drop table temp_gttl_by_month;

COMMIT;