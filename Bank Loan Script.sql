select * from bank_loan;

-- calculate total loan application amount
select count(id) as Total_Loan_Application
from bank_loan;

-- calculate month to date loan applications
select count(id) as MTD_Total_Loan_Application
from bank_loan
where month(issue_date) = 12
and year(issue_date) = 2021;

-- calcualte previous month loan application
select count(id) as PMTD_Total_Loan_Application
from bank_loan
where month(issue_date) = 11
and year(issue_date) = 2021;

-- calculate total funded amount
select sum(loan_amount) as Total_Funded_Amount
from bank_loan;

-- calculate month to date total funded amount
select sum(loan_amount) as MTD_Total_Funded_Amount
from bank_loan
where month(issue_date) = 12
and year(issue_date) = 2021;

-- calculate previous total funded amount
select sum(loan_amount) as PMTD_Total_Funded_Amount
from bank_loan
where month(issue_date) = 11
and year(issue_date) = 2021;

-- calculate total amount received
select sum(total_payment) as Total_Amount_Received
from bank_loan;

-- calculate month to date total received amount
select sum(total_payment) as MTD_Total_Amount_Received
from bank_loan
where month(issue_date) = 12
and year(issue_date) = 2021;

-- calculate previous month total received amount
select sum(total_payment) as PMTD_Total_Amount_Received
from bank_loan
where month(issue_date) = 11
and year(issue_date) = 2021;

-- calculate average interest rate
select round(avg(int_rate),2) * 100 as AVG_Interest_Rate
from bank_loan;

-- calculate month to date average interest rate
select round(avg(int_rate),2) * 100 as MTD_AVG_Interest_Rate
from bank_loan
where month(issue_date) = 12
and year(issue_date) = 2021;

-- calculate previous month average interest rate
select round(avg(int_rate),4) * 100 as PMTD_AVG_Interest_Rate
from bank_loan
where month(issue_date) = 11
and year(issue_date) = 2021;

-- calculate average DTI 
select round(avg(dti),4) * 100 as Avg_DTI
from bank_loan;

-- calculate MTD average DTI 
select round(avg(dti),4) * 100 as MTD_Avg_DTI
from bank_loan
where month(issue_date) = 12
and year(issue_date) = 2021;

-- calculate previous month AVG DTI
select round(avg(dti),4) * 100 as PMTD_Avg_DTI
from bank_loan
where month(issue_date) = 11
and year(issue_date) = 2021;

-- calculate good loan percentage
select 
(count(case when loan_status = 'Current' or loan_status = 'Fully Paid' then 'id' end) * 100)/
count('id') as good_loan_percentage
from bank_loan;

-- count good loan apllications
select count(id) as good_loan_applications
from bank_loan 
where loan_status in ('Current','Fully Paid');


-- good loan amount funded
select sum(loan_amount) as good_loan_aamount_funded
from bank_loan 
where loan_status in ('Current','Fully Paid');


-- good loan amount received from borrower
select sum(total_payment) as good_loan_total_amount_received
from bank_loan 
where loan_status in ('Current','Fully Paid');

-- calculate bad loan percentage
select 
(count(case when loan_status = 'Charged Off' then 'id' end) * 100)/
count('id') as bad_loan_percentage
from bank_loan;

-- count good loan apllications
select count(id) as badd_loan_applications
from bank_loan 
where loan_status in ('Charged Off');


-- good loan amount funded
select sum(loan_amount) as bad_loan_aamount_funded
from bank_loan 
where loan_status in ('Charged Off');


-- good loan amount received from borrower
select sum(total_payment) as bad_loan_total_amount_received
from bank_loan 
where loan_status in ('Charged Off');

-- give me total loan applications, total amount funded , total amount received, average Interest rate, average DTI for each loan_status
select loan_status,
count(loan_status) as LoanCount,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received,
avg(int_rate * 100) as avg_interest_rate,
avg(dti * 100) as DTI
from bank_loan
group by loan_status;

-- calculate month to date total amount funded and total amount received for each loan status
select loan_status,
sum(loan_amount) as MTD_Total_Funded_Amount,
sum(total_payment) as MTD_Total_Amount_Received
from bank_loan
where month(issue_date) = 12
group by loan_status;

-- Monthly Trend by issue date
select month(issue_date) as month_number,
datename(month,issue_date) as month_name,
count(id) as loan_applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from bank_loan
group by datename(month,issue_date),month(issue_date)
order by month(issue_date) desc;

-- Regional Analysis by State
select address_state,
count(id) as loan_applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from bank_loan
group by address_state
order by address_state;

-- Loan Term Analysis
select term,
count(id) as loan_applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from bank_loan
group by term
order by term;

-- Employee Length Term Analysis
select emp_length,
count(id) as loan_applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from bank_loan
group by emp_length
order by emp_length;

-- loan purpose analysis
select purpose,
count(id) as loan_applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from bank_loan
group by purpose
order by Total_Funded_Amount desc;

--Home Ownership Metrics Analysis
select home_ownership,
count(id) as loan_applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from bank_loan
group by home_ownership
order by Total_Funded_Amount desc;