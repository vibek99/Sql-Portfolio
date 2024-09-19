create schema finance1;
select*from finance1;
select*from finance2;
select count(*) finance2;
ALTER TABLE Bnk_loan RENAME TO finance1;


UPDATE finance1
SET issue_d = STR_TO_DATE(issue_d, '%d-%m-%Y');
Alter table finance1
drop column issue_date;

----------------------------------------------- updation ---------------------------------------------------------------------
-- BANK_LOAN_ANALYSIS

-- KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1)

select year(issue_d) as year_of_issue,sum(loan_amnt) as loan_amount
from finance1
group by year(issue_d)
order by (loan_amount)desc;

-- KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1)


-- KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2)

select grade,sub_grade,sum(revol_bal) as total_bal
from finance1 inner join finance2
on(finance1.id=finance2.id)
group by grade,sub_grade
order by grade,sub_grade;

-- KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2)


-- KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3) V KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3) KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3) KPI(3)  KPI(3)  KPI(3)  KPI(3)

select verification_status, 
concat("$", format (round(sum(total_pymnt)/1000000,2),2),"M")as total_payment
from finance1 inner join finance2
on(finance1.id=finance2.id)
group by verification_status;

-- KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3) KPI(3)  KPI(3)  KPI(3)  KPI(3)  KPI(3) KPI(3) KPI(3) KPI(3)



-- KP1(4) KP1(4) KP1(4) KP1(4) KP1(4) KP1(4)  KP1(4) KP1(4) KP1(4) KP1(4) KP1(4) KP1(4)  KP1(4) KP1(4) KP1(4) KP1(4) KP1(4) KP1(4)  KP1(4) 


select addr_state,last_credit_pull_d,loan_status
from finance1 inner join finance2
on(finance1.id=finance2.id)
group by addr_state,loan_status,last_credit_pull_d
order by last_credit_pull_d ;  

-- KP1(4) KP1(4) KP1(4) KP1(4) KP1(4) KP1(4)  KP1(4) KP1(4) KP1(4) KP1(4) KP1(4) KP1(4)  KP1(4) KP1(4) KP1(4) KP1(4) KP1(4) KP1(4) KP1(4) KP1(4)


-- KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5)

select COALESCE (year (last_pymnt_d),'None') as Last_pymnt_date,home_ownership, concat("$", format (round(sum(total_pymnt)/1000,2),2),"k")as total_payment
from finance1 inner join finance2
on(finance1.id=finance2.id)
group by home_ownership, Last_pymnt_date 
order by  home_ownership;

-- KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5)
