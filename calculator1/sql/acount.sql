set names utf8;
set foreign_key_checks=0;

drop database if exists acount;
create database if not exists acount;
use acount;

create table acount_info_transaction(
name1 varchar(30),
name2 varchar(30),
age varchar(3),
sex varchar(3));