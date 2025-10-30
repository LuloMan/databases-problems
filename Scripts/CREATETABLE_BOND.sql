create table bond(
	id int primary key,
	title varchar(50) unique,
	released int not null,
	actor varchar(30),
	director varchar(30),
	box_office decimal(5,1) default 0.0
);

drop table bond;