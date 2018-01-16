set names utf8;
set foreign_key_checks=0;

drop database if exists acount;
create database if not exists acount;
use acount;

create table acount_info_transaction(
name1 varchar(30),
name2 varchar(30),
birth_year varchar(16),
birth_month varchar(8),
birth_day varchar(4),
sex varchar(2),
insert_date datetime);

insert into acount_info_transaction(name1,name2,birth_year,birth_month,birth_day,sex) values("takahashi","yuuri","1991","05","07","1")