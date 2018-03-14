--�󒍌���N�x�\���ɂ���
select case when date_part('month',date_of_orders) < 4 then date_part('year',date_of_orders)-1 else date_part('year',date_of_orders) end as nendo from sales_tbl;
--���N�x
select case when date_part('month',current_date) < 4 then date_part('year',current_date)-1 else date_part('year',current_date) end as fiscal_year;


--�W�v�����d������f�[�^���폜
delete from orders_and_sales_tbl where exists (select * from orders_and_sales_tbl where aggregate_date = current_date);

--�W�v�����d������f�[�^���Ȃ���ΐe�e�[�u����insert
INSERT INTO orders_and_sales_tbl(aggregate_date, pre_year_orders, next_year_orders, created_at)
SELECT current_date, �O��, ����, current_timestamp
WHERE NOT EXISTS (SELECT aggregate_date FROM orders_and_sales_tbl WHERE aggregate_date = current_date);

--�߂�l���e�e�[�u����id�ɂȂ�insert��
INSERT INTO orders_and_sales_tbl(aggregate_date, pre_year_orders, next_year_orders, created_at)
SELECT current_date, 1000, 1000, current_timestamp
WHERE NOT EXISTS (SELECT * FROM orders_and_sales_tbl WHERE aggregate_date = current_date)
RETURNING orders_and_sales_tbl.id;

--�֐����g�p����insert�A�e�e�[�u��id���擾
select orders_and_sales_id();

--�ʍ��v�E�ʑ��v �󒍃e�[�u�� �O����
SELECT SUM(value_of_order) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year < (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND sales_status_name = '�󒍍�';

--�ʍ��v �󒍃e�[�u�� ������
SELECT SUM(value_of_order) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year > (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND sales_status_name = '�󒍍�';

--�ʍ��v 4�� ��
SELECT coalesce(SUM(value_of_order), 0) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND date_part('month',date_of_orders) = 4 
AND sales_status_name = '�󒍍�';

--�ʍ��v 4�� ����
SELECT coalesce(SUM(value_of_order), 0) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_orders) < 4 THEN date_part('year',date_of_orders)-1 ELSE date_part('year',date_of_orders) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND date_part('month',date_of_sales) = 4 
AND sales_status_name = '�����';


--���v���ޕ�
--���ޕʁ@�󒍍�
SELECT coalesce(SUM(value_of_order), 0) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND sales_status_name = '�󒍍�' 
AND cat_name = 'test00';
--���ޕʁ@�����
SELECT coalesce(SUM(value_of_order), 0) 
FROM (SELECT *, CASE WHEN date_part('month',date_of_sales) < 4 THEN date_part('year',date_of_sales)-1 ELSE date_part('year',date_of_sales) END AS fiscal_year FROM sales_tbl) as a 
WHERE fiscal_year = (SELECT CASE WHEN date_part('month',current_date) < 4 THEN date_part('year',current_date)-1 ELSE date_part('year',current_date) END) 
AND sales_status_name = '�����' 
AND cat_name = 'test00';


--���ʑ��v
--����W�v����4������12���̃f�[�^
select * from monthly_orders_and_sales_tbl where orders_and_sales_tbl_id = 16 and month_val >= 4 order by month_val;
--�݌v�l
select month_val, orders_total_val, sales_total_val, sum(orders_total_val) over(order by month_val asc) as gttl_order, sum(sales_total_val) over (order by month_val asc) as gttl_sales 
from monthly_orders_and_sales_tbl where orders_and_sales_tbl_id = 16 and month_val >= 4 order by month_val;
--�ꎞ�e�[�u����4������12���̗݌v�f�[�^������
create temporary table gttl_4to12 as 
select month_val, sum(orders_total_val) over(order by month_val asc) as gttl_order, sum(sales_total_val) over (order by month_val asc) as gttl_sales alter
from monthly_orders_and_sales_tbl 
where orders_and_sales_tbl_id = (select ttl_by_month_id from ttl_by_month_id) 
and month_val >= 4 
order by month_val;
--�ꎞ�e�[�u����1������3���̗݌v�f�[�^������
create temporary table gttl_4to12 as 
select month_val, sum(orders_total_val) over(order by month_val asc) as gttl_order, sum(sales_total_val) over (order by month_val asc) as gttl_sales alter
from monthly_orders_and_sales_tbl 
where orders_and_sales_tbl_id = (select ttl_by_month_id from ttl_by_month_id) 
and month_val < 4 
order by month_val;
--4���ɑO�����A1������3����12�����̃f�[�^�𑫂�

