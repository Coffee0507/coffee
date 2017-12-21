set names utf8;
set foreign_key_checks=0;
drop database if exists logindb;
create database logindb;
use logindb;
create table user(
user_id int,
user_name varchar(255),
password varchar(255)
);

insert into user values
(1,"taro","123"),
(2,"jiro","456"),
(3,"hanako","789"),
(4,"shiro","0000");