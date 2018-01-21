set names utf8;
set foreign_key_checks = 0;
drop database if exists ecsite;

create database if not exists ecsite;
use ecsite;

drop table if exists login_user_transaction;
drop table if exists buy_item_tarnsaction;
drop table if exists user_buy_item_transaction;

create table login_user_transaction(
id int not null primary key auto_increment,
login_id varchar(50) unique,
login_pass varchar(16),
user_name varchar(16),
insert_date datetime,
delete_date datetime);



create table buy_item_transaction(
id int not null primary key auto_increment,
item_name varchar(15),
item_price int,
item_stock int,
intert_date datetime,
delete_date datetime);

create table user_buy_item_transaction(
id int not null primary key auto_increment,
item_transaction_id int,
item_name varchar(15),
item_price int,
item_stock int,
user_master_id varchar(50),
pay varchar(50),
insert_date datetime,
delete_time datetime);

insert into login_user_transaction(login_id,login_pass,user_name) values("internous","internous01","test");
insert into buy_item_transaction(item_name,item_price,item_stock) values("notebook",100,10);