--Toatal users= 107658
select count(*) as totla_users from DIM_USERS;
--Toatal transactions= 300000
select count(*) as total_transactions from FACT_TRANSACTIONS;
--total_revenue = 3.47 billion INR
select round(sum(amount)/1000000000,2) as total_revenue_billion_INR from FACT_TRANSACTIONS;
--Average Transaction Value = 11581.07
SELECT round(AVG(AMOUNT),2) AS AVG_TRANSACTION_VALUE
FROM FACT_TRANSACTIONS;
--Successful vs Failed Payments
select payment_status, 
       count(*) as total_txn, 
       round(sum(amount)/1000000000,2) as total_payement_billion_INR from FACT_TRANSACTIONS
group by PAYMENT_STATUS
order by round(sum(amount)/1000000000,2) desc;
--INSIGHTS
---High Success Rate: Out of roughly 300,000 total transactions, the overwhelming majority (over 96%) succeeded, securing 3.33 billion in volume.
---Cost of Failures: While generic "Failed" transactions dominate the non-successful volume, preventable user errors like "Wrong PIN" and "Insufficient amount" combined to stall over 67 million in potential revenue.

---Revenue by Service Type
select service_type, 
       count(*) as total_txn, 
       round(sum(amount)/1000000,2) as total_revenue_million_INR from FACT_TRANSACTIONS
group by service_type
order by round(sum(amount)/1000000,2) desc;
--INSIGHTS
--High-Value Drivers: Financial and lending products (Bike Loans, Mutual Funds, and Gold Loans) drive the highest revenue despite lower volumes (~12k transactions each), highlighting their premium value per conversion.
--High-Volume Commodities: Transfer actions like "To UPI ID" and "To Mobile Number" generate massive user engagement (~37k transactions each) but yield the lowest financial returns, acting primarily as top-of-funnel hooks.
--Revenue by Service
select service, 
       count(*) as total_txn, 
       round(sum(amount)/1000000,2) as total_revenue_million_INR from FACT_TRANSACTIONS
group by service
order by round(sum(amount)/1000000,2) desc;
--insights
--service          total_txn	total_revenue_million_INR
--Loans	             50000	          2532.51
--Insurance	         50000	           512.92
--Money_Transfer	150000	           378.19
--Recharge_Bills	 50000	            50.69

--top 10 users by spending
select top 10 d.user_name, 
       round(sum(f.amount)/1000000,2) as total_spent_in_INR_million from FACT_TRANSACTIONS f
left join DIM_USERS d 
on f.USER_KEY = d.USER_KEY
group by d.user_name
order by sum(f.amount) desc;
--insights
--user_name	           total_spent_in_INR_million
--Michael Smith	          1.82
--Jennifer Williams	      1.57
--Michael Brown	          1.27
--Christopher Brown	      1.23
--Michael Jones	          1.21
--Robert Smith	          1.20
--Christopher Smith	      1.10
--James Johnson	          1.07
--John Smith	          1.07
--Jennifer Smith	      1.05

---Monthly Revenue Trend
select d.year,d.month_name, round(sum(f.amount)/1000000,2) as revenue_million from FACT_TRANSACTIONS f
left join  DIM_DATE d
on d.date_key = f.date_key
group by d.year,d.month_name
order by round(sum(f.amount)/1000000,2) desc;
--insights
--Peak vs. Bottom: July was  highest-performing month of the year, bringing in over 30.4 Cr, while February was the lowest at 27.8 Cr—representing a 9.1% variance between your peak and trough.
--Quarterly Consistency: revenue remained exceptionally stable throughout 2024, consistently hovering within a tight band of 27.8 Cr to 30.4 Cr per month, showcasing strong, predictable baseline demand.
--Quarterly Revenue Trend
SELECT
    D.YEAR,
    D.QUARTER,
    round(sum(F.AMOUNT)/1000000,2) AS REVENUE_MILLION
FROM FACT_TRANSACTIONS F
JOIN DIM_DATE D
ON F.DATE_KEY = D.DATE_KEY
GROUP BY
    D.YEAR,
    D.QUARTER
ORDER BY
    D.YEAR,
    D.QUARTER;
    ---insihts
--year   quarter	revenue_million
--2024	  1	        865.03
--2024	  2	        865.96
--2024	  3	        877.61
--2024	  4	        865.72

--Daily Transactions
SELECT
    D.FULL_DATE,
    COUNT(*) AS TOTAL_TXNS,
    round(SUM(F.AMOUNT)/1000000,2) AS REVENUE_MILLION
FROM FACT_TRANSACTIONS F
JOIN DIM_DATE D
ON F.DATE_KEY = D.DATE_KEY
GROUP BY D.FULL_DATE
ORDER BY D.FULL_DATE;
--insights
--Volume Peak & Trough: Daily volume averaged 822 units over the year, hitting its absolute highest peak of 900 units on May 7th and dropping to its lowest point of 741 units on March 1st.
--Rate Extremes: The rate steadily hovered around an average of 9.52, peaking sharply at  its yearly maximum of 11.52 on July 22nd, while touching its lowest base at 7.84 on August 20th.
--Age Group Analysis
SELECT
CASE
    WHEN AGE BETWEEN 18 AND 25 THEN '18-25'
    WHEN AGE BETWEEN 26 AND 35 THEN '26-35'
    WHEN AGE BETWEEN 36 AND 45 THEN '36-45'
    WHEN AGE BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
END AS AGE_GROUP,
COUNT(*) AS USERS
FROM DIM_USERS
GROUP BY
CASE
    WHEN AGE BETWEEN 18 AND 25 THEN '18-25'
    WHEN AGE BETWEEN 26 AND 35 THEN '26-35'
    WHEN AGE BETWEEN 36 AND 45 THEN '36-45'
    WHEN AGE BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
END;
--insights
--age_group     osers
--36-45	        25210
--46-60	        37590
--26-35	        25034
--18-25	        19824

--Revenue by Age Group
SELECT
CASE
    WHEN U.AGE BETWEEN 18 AND 25 THEN '18-25'
    WHEN U.AGE BETWEEN 26 AND 35 THEN '26-35'
    WHEN U.AGE BETWEEN 36 AND 45 THEN '36-45'
    WHEN U.AGE BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
END AS AGE_GROUP,
round(SUM(F.AMOUNT)/10000000,2) AS REVENUE_MILLION
FROM FACT_TRANSACTIONS F
JOIN DIM_USERS U
ON F.USER_KEY = U.USER_KEY
group by CASE
    WHEN U.AGE BETWEEN 18 AND 25 THEN '18-25'
    WHEN U.AGE BETWEEN 26 AND 35 THEN '26-35'
    WHEN U.AGE BETWEEN 36 AND 45 THEN '36-45'
    WHEN U.AGE BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
END
ORDER BY REVENUE_MILLION DESC;
--insights
--age_group        revenue_million
--46-60	           121.58
--36-45	           81.40
--26-35	           79.66
--18-25	           64.80

--Failure Reason Analysis
SELECT
    REASON,
    COUNT(*) AS TOTAL_FAILURES
FROM FACT_TRANSACTIONS
WHERE PAYMENT_STATUS = 'Failed'
GROUP BY REASON
ORDER BY TOTAL_FAILURES DESC;
---reason              total_failuers
---Server error	         3361
--Wrong PIN	             3315
--Insufficient amount	 3304






SELECT @@SERVERNAME;