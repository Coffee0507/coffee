set names utf8;
set foreign_key_checks = 0;

drop database if exists Portal;

create database if not exists portal;

use portal;

drop table if exists user_info;
drop table if exists post_info;
drop table if exists favorite_info;
drop table if exists follow_info;
drop table if exists notice_info;


create table user_info(
id int not null primary key auto_increment,
user_id varchar(16),
password varchar(16),
user_name varchar(30),
self_introduction varchar(150),
place varchar(30),
draft varchar(150),
followers_count int
);


create table post_info(
id int,
user_id int,
post_id int,
contents varchar(150),
post_taime date,
favorite_count int
);


create table favorite_info(
id int,
user_id varchar(16),
favorite_post_id int,
input_time date
);


create table follow_info(
id int,
send int,
receive int,
follow_time date
);


create table notice_info(
id int,
user_id int,
notice_content int
);
