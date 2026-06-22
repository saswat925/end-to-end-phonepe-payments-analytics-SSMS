# end-to-end-phonepe-payments-analytics-SSMS

# End-to-End PhonePe Payments Analytics Project

## Project Overview

This project demonstrates a complete Data Analytics workflow using SQL Server and Power BI. The objective was to build a scalable analytics solution for PhonePe payment transactions by implementing data ingestion, cleaning, validation, dimensional modeling, SQL analytics, and interactive dashboards.

## Tech Stack

* SQL Server
* SQL Server Management Studio (SSMS)
* Power BI Desktop
* DAX
* GitHub

---

# Architecture

Raw CSV Files
→ Staging Layer
→ Data Cleaning Layer
→ Data Quality Checks
→ Data Warehouse Layer
→ Star Schema
→ Power BI Dashboard

---

# Dataset Summary

| Metric                    | Value         |
| ------------------------- | ------------- |
| Total Users               | 107,658       |
| Total Transactions        | 300,000       |
| Total Revenue             | ₹3.47 Billion |
| Average Transaction Value | ₹11,581.07    |

---

# Data Engineering Process

## 1. Database Creation

Created a dedicated SQL Server database:

```sql
CREATE DATABASE PAYMENTS_DB;
```

---

## 2. Staging Layer

Created staging tables:

* STG_USERS
* STG_TRANSACTIONS

Loaded CSV files using BULK INSERT.

---

## 3. Data Cleaning

Created clean tables:

### USERS_CLEAN

* Trimmed spaces
* Converted Age to Integer
* Converted Join Date to Date datatype

### TRANSACTIONS_CLEAN

* Converted Amount to Decimal
* Standardized text fields
* Converted Transaction Date to Date datatype

---

## 4. Data Quality Checks

Performed multiple validation checks:

### Null Checks

* User ID
* User Name
* Age
* Join Date
* Transaction ID
* Amount
* Transaction Date

Result:
No null values found.

### Duplicate Checks

* User ID
* Transaction ID

Result:
No duplicate records found.

### Invalid Data Checks

* Invalid Age
* Negative Amount
* Future Dates

Result:
No invalid records found.

### Referential Integrity

Checked orphan transactions.

Result:
No orphan records found.

---

# Database Constraints

## Primary Keys

### USERS_CLEAN

* PK_USERS

### TRANSACTIONS_CLEAN

* PK_TRANSACTIONS

## Foreign Keys

### TRANSACTIONS_CLEAN

* FK_TRANSACTIONS_USERS

---

# Data Warehouse Design

Implemented a Star Schema.

## Dimension Tables

### DIM_USERS

* USER_KEY
* USER_ID
* USER_NAME
* AGE
* JOIN_DATE

### DIM_DATE

* DATE_KEY
* FULL_DATE
* YEAR
* QUARTER
* MONTH_NO
* MONTH_NAME
* DAY_NO

## Fact Table

### FACT_TRANSACTIONS

* TRANSACTION_ID
* USER_KEY
* DATE_KEY
* AMOUNT
* SERVICE
* SERVICE_TYPE
* PAYMENT_STATUS
* REASON

---

# Star Schema

DIM_USERS (1)
|
|
FACT_TRANSACTIONS
|
|
DIM_DATE (1)

---

# Business Analysis

## Payment Performance

| Status  | Transaction Count | Revenue (Billion INR) |
| ------- | ----------------- | --------------------- |
| Success | Majority          | ₹3.33 B               |
| Failed  | Minority          | Remaining Volume      |

### Insights

* Over 96% of transactions were successful.
* Failed transactions represented a relatively small share of overall volume.
* Wrong PIN and Insufficient Amount were major preventable failure reasons.

---

## Revenue by Service

| Service          | Revenue (Million INR) |
| ---------------- | --------------------- |
| Loans            | 2532.51               |
| Insurance        | 512.92                |
| Money Transfer   | 378.19                |
| Recharge & Bills | 50.69                 |

### Insights

* Loans generated the highest revenue.
* Insurance was the second largest contributor.
* Money Transfer drove high engagement but lower revenue per transaction.

---

## Revenue by Service Type

### Top Revenue Drivers

* Bike Loans
* Mutual Funds
* Gold Loans

### Insights

* Lending and investment products generated significantly higher value per transaction.
* Transfer services drove user engagement and transaction volume.

---

## User Spending Analysis

### Top Spenders

1. Michael Smith
2. Jennifer Williams
3. Michael Brown
4. Christopher Brown
5. Michael Jones

### Insight

A small percentage of users contributed disproportionately to total revenue.

---

## Monthly Revenue Trend

### Insights

* July recorded the highest monthly revenue.
* February recorded the lowest monthly revenue.
* Revenue remained highly stable throughout the year.

---

## Quarterly Revenue Trend

| Quarter | Revenue (Million INR) |
| ------- | --------------------- |
| Q1      | 865.03                |
| Q2      | 865.96                |
| Q3      | 877.61                |
| Q4      | 865.72                |

### Insight

Revenue remained consistently strong across all quarters.

---

## Age Group Analysis

| Age Group | Users  |
| --------- | ------ |
| 18-25     | 19,824 |
| 26-35     | 25,034 |
| 36-45     | 25,210 |
| 46-60     | 37,590 |

### Insights

* Users aged 46–60 represented the largest customer segment.
* Younger users generated lower transaction volume compared to older groups.

---

## Revenue by Age Group

| Age Group | Revenue        |
| --------- | -------------- |
| 46-60     | Highest        |
| 36-45     | Second Highest |
| 26-35     | Third          |
| 18-25     | Lowest         |

### Insight

Older customers contributed the largest share of revenue.

---

## Failure Reason Analysis

| Reason              | Failures |
| ------------------- | -------- |
| Server Error        | 3,361    |
| Wrong PIN           | 3,315    |
| Insufficient Amount | 3,304    |

### Insights

* Server-related issues were the leading failure cause.
* User mistakes such as Wrong PIN represented a significant share of failed transactions.

---

# Power BI Dashboard

## Executive Dashboard

KPIs

* Total Revenue
* Total Transactions
* Total Users
* Average Transaction Value
* Success Rate

Visuals

* Revenue Trend
* Revenue by Service
* Payment Status Distribution
* Top Users Analysis

## User Analytics Dashboard

* Users by Age Group
* Revenue by Age Group
* User Growth Trend
* Top Spending Users

## Transaction Analytics Dashboard

* Revenue by Service Type
* Daily Revenue Trend
* Failure Reason Analysis
* Quarterly Revenue Analysis

---

# Key Skills Demonstrated

* SQL Development
* Data Cleaning
* Data Validation
* Data Quality Checks
* Data Warehousing
* Star Schema Modeling
* Fact & Dimension Design
* ETL Concepts
* Business Analytics
* Power BI
* DAX
* Dashboard Development

---

# Project Outcome

Successfully designed and implemented an end-to-end analytics solution capable of processing 300,000 transactions and 107,658 users while delivering actionable business insights through SQL Server and Power BI.



