# End-to-End PhonePe Payments Analytics Project

## Overview

This project demonstrates an industry-standard End-to-End Data Analytics workflow using SQL Server, Python, and Power BI. The objective of this project is to transform raw payment transaction data into business-ready analytical insights through ETL processing, dimensional modeling, statistical analysis, and interactive dashboard development.

The project covers:

- SQL Server ETL Pipeline
- Data Cleaning & Validation
- Star Schema Modeling
- Python Data Analysis
- Statistical Analysis
- Business Intelligence Reporting
- Power BI Dashboard Development
- Business Insights & Recommendations

---

## Project Architecture

```
                 CSV Files
                     |
                     |
                SQL Server
                     |
                     |
              Staging Tables
                     |
                     |
               Data Cleaning
                     |
                     |
              Data Validation
                     |
                     |
            Primary & Foreign Keys
                     |
                     |
                Star Schema
                     |
         ------------------------------
         |                            |
      DIM_USERS                   DIM_DATE
         |                            |
         --------FACT_TRANSACTIONS------
                      |
                      |
                    Python
                      |
                      |
               Data Analysis
                      |
                      |
                  Power BI
                      |
                      |
                Interactive Dashboard
                      |
                      |
               Business Insights
```

---

## Tools & Technologies

| Technology | Purpose |
|------------|---------|
| SQL Server | ETL Pipeline |
| SQL | Data Cleaning |
| Python | Data Analysis |
| Pandas | Data Manipulation |
| NumPy | Statistical Analysis |
| Matplotlib | Visualization |
| SQLAlchemy | SQL Connection |
| Power BI | Dashboard Development |
| Git & GitHub | Version Control |
| Jupyter Notebook | Analysis |

---

## Dataset Information

### Users Dataset

```
107,658 Users
```

Contains:

- User ID
- User Name
- Age
- Join Date

### Transactions Dataset

```
300,000 Transactions
```

Contains:

- Transaction ID
- Amount
- User ID
- Service
- Service Type
- Payment Status
- Failure Reason
- Transaction Date


---

## SQL ETL Workflow

### Step 1

```
Create Database
       |
       |
Staging Tables
       |
       |
Bulk Insert
       |
       |
Data Cleaning
       |
       |
Data Validation
       |
       |
Constraints
       |
       |
Star Schema
       |
       |
Business Analysis
```

---

## Data Validation Performed

### Users Table

- Null Validation
- Duplicate Validation
- Invalid Age Check
- Future Date Validation

### Transactions Table

- Null Validation
- Duplicate Validation
- Negative Amount Validation
- Future Date Validation
- Orphan Record Validation
- Referential Integrity Validation

---

## Constraints Applied

### Primary Keys

```
USERS_CLEAN

USER_ID
------------

TRANSACTIONS_CLEAN

TRANSACTION_ID
----------------
```

### Foreign Keys

```
USER_ID

↓

TRANSACTIONS_CLEAN
        |
        |
        ↓
USERS_CLEAN


DATE_KEY

↓

FACT_TRANSACTIONS
        |
        |
        ↓
DIM_DATE
```

---

## Star Schema Design

```
                DIM_USERS
                    |
                    |
                    |
                    |
            FACT_TRANSACTIONS
                    |
                    |
                    |
                 DIM_DATE
```


### Dimension Tables

#### DIM_USERS

Contains:

- USER_KEY
- USER_ID
- USER_NAME
- AGE
- JOIN_DATE

#### DIM_DATE

Contains:

- DATE_KEY
- FULL_DATE
- YEAR
- QUARTER
- MONTH_NUMBER
- MONTH_NAME
- DAY_NUMBER

#### FACT_TRANSACTIONS

Contains:

- TRANSACTION_ID
- USER_KEY
- DATE_KEY
- AMOUNT
- SERVICE
- SERVICE_TYPE
- PAYMENT_STATUS
- REASON


---

## Python Workflow

```
SQL Server Connection
         |
         |
      Data Pull
         |
         |
      Validation
         |
         |
      Merge Tables
         |
         |
       Cleaning
         |
         |
         EDA
         |
         |
   Statistical Analysis
         |
         |
    Visualization
         |
         |
     Business Insights
```

---

## Executive KPIs

| KPI | Value |
|------|------|
| Total Revenue | ₹3.47 Billion |
| Total Transactions | 300,000 |
| Total Users | 107,658 |
| Average Transaction Value | ₹11,581 |
| Transaction Success Rate | >96% |
| Total Outliers | 40,779 |
| Revenue Contribution | Loans - 72.89% |

---

## Analysis Performed

### Payment Analysis

- Successful Transactions
- Failed Transactions
- Wrong PIN Analysis
- Server Error Analysis
- Insufficient Amount Analysis


### Service Analysis

- Revenue by Service
- Transactions by Service
- Revenue Contribution Analysis


### Customer Analysis

- Top Customers by Revenue
- Top Customers by Transactions


### Time Analysis

- Yearly Revenue
- Quarterly Revenue
- Monthly Revenue Trend
- Daily Transaction Trend


### Age Group Analysis

```
18-25

26-35

36-45

46-60

60+
```


Performed:

- Total Users
- Revenue Contribution
- Customer Segmentation


### Statistical Analysis

Performed:

```
IQR Method

Q1
Q2
Q3

↓

Outlier Detection

↓

Correlation Analysis

↓

Business Insights
```

---

## Power BI Dashboard

### Dashboard Pages

#### Executive Dashboard

Contains:

- Total Revenue
- Total Transactions
- Total Users
- Average Transaction Value
- Success Rate


#### Service Analysis

Contains:

- Revenue by Service
- Revenue Contribution
- Transactions by Service


#### Time Analysis

Contains:

- Monthly Revenue Trend
- Quarterly Revenue
- Daily Transactions


#### Customer Analysis

Contains:

- Top 10 Customers
- Top Spending Customers
- Customer Segmentation


#### Payment Analysis

Contains:

- Failed Transactions
- Wrong PIN Analysis
- Failure Reasons
- Success Rate Analysis


#### Statistical Dashboard

Contains:

- Outlier Analysis
- Correlation Analysis
- Revenue Distribution


---

## Power BI Features

Implemented:

- Cards
- KPI Indicators
- Line Charts
- Bar Charts
- Pie Charts
- Slicers
- Drill Through
- Filters
- Bookmarks
- Tooltips
- Interactive Visualizations


---

## Key Insights

- Successfully analyzed 300,000 payment transactions.
- The platform achieved more than 96% successful transactions.
- Loans generated the highest revenue contribution.
- Money Transfer generated the highest transaction volume.
- Revenue remained highly stable across all four quarters.
- Customers aged 46–60 generated the highest revenue.
- Payment failures were primarily caused by Server Errors, Wrong PIN, and Insufficient Amount.
- Outlier analysis identified unusual transaction patterns useful for fraud monitoring.
- Correlation analysis revealed negligible linear relationships among most business variables.
- Data validation confirmed the absence of null values, duplicates, and orphan records.


---

## Business Recommendations

- Improve payment failure handling mechanisms.
- Target high-value customers using personalized campaigns.
- Optimize Money Transfer monetization strategies.
- Introduce fraud monitoring for abnormal transactions.
- Improve customer retention among premium users.
- Strengthen payment gateway reliability to reduce failed transactions.


---

## Project Highlights

- End-to-End ETL Pipeline
- SQL Server Data Warehousing
- Star Schema Modeling
- Data Cleaning & Validation
- Python Statistical Analysis
- Power BI Dashboarding
- Business Intelligence Reporting
- Interactive Data Visualization
- Portfolio Ready Project
- Industry Standard Analytics Workflow


---

## Conclusion

This End-to-End PhonePe Payments Analytics project demonstrates practical expertise in SQL, Python, Power BI, Data Warehousing, ETL Processing, Statistical Analysis, and Business Intelligence Reporting. The project transforms raw transactional data into actionable business insights through scalable analytics workflows and interactive dashboards, closely reflecting real-world Data Analyst responsibilities.

```


### GitHub Topics

Use these tags:

```
SQL
SQL-Server
Python
PowerBI
Pandas
ETL
EDA
Data-Analytics
Business-Intelligence
Data-Warehouse
Star-Schema
Dashboard
PhonePe
GitHub-Portfolio
```

This README structure is ATS-friendly, recruiter-friendly, and suitable for showcasing an end-to-end Data Analyst project on GitHub with both the SQL and Power BI components clearly documented.
