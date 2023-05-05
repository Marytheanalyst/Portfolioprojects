--SECTION 1: Part 2
SELECT TOP 100 *
FROM lendingclubloans;

-- Query to show loan and funded amounts
SELECT loan_amnt, COUNT(*) as num_customers
FROM lendingclubloans
GROUP BY loan_amnt

-- Query to show number of customers based on funded amount
SELECT COUNT(*) as num_customers
FROM lendingclubloans
WHERE funded_amnt = 10000

SELECT COUNT(*) as num_customers
FROM lendingclubloans
WHERE funded_amnt < 10000

SELECT COUNT(*) as num_customers
FROM lendingclubloans
WHERE funded_amnt > 10000

--Loan Terms
SELECT term, COUNT(*) as num_loans
FROM lendingclubloans
GROUP BY term;
 
--Interest rate
SELECT AVG(int_rate) as avg_interest_rate,
       MAX(int_rate) as max_interest_rate,
       MIN(int_rate) as min_interest_rate
FROM lendingclubloans;

--Loan Status
SELECT COUNT(DISTINCT loan_status) AS num_unique_statuses
FROM lendingclubloans;

SELECT DISTINCT loan_status
FROM lendingclubloans

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Current';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Issued';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Fully Paid';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Default';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Late (31-120 days)';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Does not meet the credit policy. Status:Fully Paid';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Charged Off';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'In Grace Period';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Does not meet the credit policy. Status:Charged Off';

SELECT TOP 100 *
FROM lendingclubloans
WHERE loan_status = 'Late (16-30 days)';

--Loan grades
SELECT grade, COUNT(*) AS num_loans
FROM lendingclubloans
GROUP BY grade
ORDER BY num_loans DESC;

SELECT sub_grade, COUNT(*) AS num_loans
FROM lendingclubloans
GROUP BY sub_grade
ORDER BY num_loans DESC;

--Loan Defaults
--No. of customers that defaulted
SELECT COUNT(*) AS num_defaulted_loans
FROM lendingclubloans
WHERE loan_status = 'Default';

SELECT COUNT(DISTINCT member_id) AS num_defaulted
FROM lendingclubloans
WHERE loan_status = 'Default';


--Select query for Tableau
SELECT *
FROM lendingclubloans;

