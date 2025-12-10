use bankloananalysis;
show tables;
FLUSH TABLES og1;
SELECT COUNT(*) FROM og1;
select count(*) from og1;
select count(issue_date) from og;
select distinct issue_date from og;
select min(issue_date) from og;
rollback;
select year(issue_date),loan_amnt from og limit 10;
select issue_date,issue_d from og;


select count(*) from finance_2;
alter table og1 add column issue_date date;
update og1 set issue_date=str_to_date(issue_d,'%d-%m-%Y');

/*1st kpi-Year wise loan amount Stats */
select concat(format(sum(loan_amnt)/1000000,0),"M") as yr_wise ,year(issue_date) as yr from og1 where issue_date is not null group by year(issue_date)
order by yr;


alter table og drop issue_d;


/* 2nd kpi-Grade and sub grade wise revol_bal */
select concat(format(sum(revol_bal)/1000000,0),"M") as revol,grade,sub_grade from 
finance_2 join og 
on finance_2.id=og.id group by grade,sub_grade;

/*3rd kpi-Total Payment for Verified Status Vs Total Payment for Non Verified Status */
select concat(format(sum(total_pymnt)/1000000,2),"M") as revolve_status,verification_status from finance_2
join og 
on finance_2.id=og.id where verification_status in ("verified","not verified") group by verification_status;


/*4th kpi-State wise and month wise loan status */
select count(loan_status) as ct,addr_state from og
join finance_2
on og.id=finance_2.id group by addr_state order by ct desc;

/* 5th kpi-Home ownership Vs last payment date stats */
select count(last_pymnt_d),home_ownership from 
og join finance_2
on og.id=finance_2.id group by home_ownership;






alter table finance_2 add column last_pymnt_date date;
update finance_2
set last_pymnt_d=  str_to_date(concat('01-',last_pymnt_d),'%d-%b-%y') where last_pymnt_d is not null and last_pymnt_d <> "";
select distinctrow last_pymnt_d from finance_2 order by last_pymnt_d;
update finance_2
set last_pymnt_d='01-jan=2000' where last_pymnt_d is null or last_pymnt_d <> "";
select version();
select id,member_id,row_number() over(order by loan_amnt desc) as row_nbr from finance1;
select rank() over(order by loan_amnt desc) as rnk_nr from finance1;
select id,loan_amnt,member_id,dense_rank() over( order by loan_amnt desc) as rk from og1 limit 3;
select year(issue_date),sum(loan_amnt) over(partition by id order by year(issue_date) )as ln from og1;
select monthname(issue_date),count(loan_amnt) over(order by month(issue_date)) as mn from og1;
select id,loan_amnt,lag(loan_amnt) over(order by id  ) as ip_ from og1;
select id,loan_amnt,lead(loan_amnt) over(partition by id  ) as ip from og1;
select count(id) from og1;
select id, loan_amnt,row_number() over(order by loan_amnt desc) as nb from og1;
select year(issue_date), avg(loan_amnt) over(order by issue_date) from og1 where year(issue_date)=2011;
select id,loan_amnt,lag(loan_amnt) over(order by id) as prev_,lead(loan_amnt) over(order by id) as curr_ from og1;
select id,first_value(loan_amnt) over(order by id) as loanamnt ,last_value(loan_amnt) over(order by id) as lastvalue from og1;
select loan_amnt,row_number() over(order by loan_amnt desc) as loanamnt from og1 limit 2;
select percent_rank() over(order by loan_amnt) as la from og1;
select cume_dist() over(order by loan_amnt) as la from og1;






