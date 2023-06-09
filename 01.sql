/* 1. Cancellation Rates.

Writing a query to return the publication and cancellation 
rate for each user*/

create table users_p1 (user_id integer, action varchar(9), dates
date);

insert into users_p1 with
names as (select 1,'start','01-jan-20' from dual union all
select 1,'cancel','02-jan-20' from dual union all
select 2,'start','03-jan-20' from dual union all
select 1,'start','03-jan-20' from dual union all
select 1,'publish','04-jan-20' from dual union all
select 2,'publish','04-jan-20' from dual union all
select 3,'start','05-jan-20' from dual union all
select 3,'cancel','06-jan-20' from dual union all
select 4,'start','07-jan-20' from dual)
select * from names;

select * from users_p1; 

create table totals_p1 as
select user_id, sum(case when action='start' then 1 else 0 end) as starts,
sum(case when action='cancel' then 1 else 0 end) as cancels,
sum(case when action='publish' then 1 else 0 end) as publishes
from users_p1
group by user_id
order by user_id;

select * from totals_p1;

select user_id, 1.0*publishes/starts as publish_rate, 1.0*cancels/starts as cancel_rate
from totals_p1;
