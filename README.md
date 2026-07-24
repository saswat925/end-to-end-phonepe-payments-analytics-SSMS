# End-to-End PhonePe Payments Analytics (SQL Server + Power BI)

## Overview

This project demonstrates an end-to-end Data Analytics and Business Intelligence solution built using SQL Server, Python, and Power BI. The objective was to design and implement a scalable payment analytics system capable of processing large transaction volumes while transforming raw transactional data into meaningful business insights.

The project follows industry-standard Data Analytics workflows including ETL processing, data quality validation, dimensional modeling using Star Schema, SQL analytics, statistical analysis, and interactive dashboard development.

The complete pipeline covers:

* Data Ingestion
* ETL Processing
* Data Cleaning & Validation
* Data Warehousing
* Star Schema Modeling
* Exploratory Data Analysis (EDA)
* Statistical Analysis
* Business Intelligence Reporting
* Interactive Power BI Dashboard Development
* Business Insight Generation

---

## Tech Stack

| Technology      | Purpose                   |
| --------------- | ------------------------- |
| SQL Server      | Database Management       |
| SSMS            | SQL Development           |
| SQL             | Data Cleaning & Analytics |
| Python (Pandas) | Data Analysis             |
| Matplotlib      | Data Visualization        |
| Seaborn         | Statistical Visualization |
| Power BI        | Dashboard Development     |
| DAX             | KPI Calculations          |
| Git & GitHub    | Version Control           |

---

## Project Architecture

```
                    Raw CSV Files
                           |
                           |
                     Data Ingestion
                           |
                           |
                      Staging Layer
            --------------------------------
            |                              |
        STG_USERS                  STG_TRANSACTIONS
                           |
                           |
                     Data Cleaning
                           |
                           |
                   Data Quality Checks
       ----------------------------------------------
       |                  |                |          |
      Nulls          Duplicates      Data Integrity    FK Validation
                           |
                           |
                     Cleaned Layer
             --------------------------------
             |                              |
         USERS_CLEAN                TRANSACTIONS_CLEAN
                           |
                           |
                    Data Warehouse
                           |
                           |
                      Star Schema
                           |
            ------------------------------------
            |                                  |
        DIM_USERS                    FACT_TRANSACTIONS
                                              |
                                              |
                                          DIM_DATE
                           |
                           |
                     SQL Analytics
                           |
                           |
                   Statistical Analysis
                           |
                           |
                   Power BI Dashboards
                           |
                           |
                     Business Insights
```

---

## Dataset Summary

| Metrics                   | Values        |
| ------------------------- | ------------- |
| Total Users               | 107,658       |
| Total Transactions        | 300,000       |
| Total Revenue             | ₹3.47 Billion |
| Average Transaction Value | ₹11,581.07    |
| Database                  | PAYMENTS_DB   |

---

## Key Business Questions

This project answers several business-critical questions:

* What is the overall payment success rate?
* Which services generate maximum revenue?
* Which users contribute the highest transaction value?
* How does revenue vary monthly and quarterly?
* Which age groups generate the most revenue?
* What are the major transaction failure reasons?
* Are there abnormal transaction patterns or outliers?
* What relationships exist between business variables?

---

## ETL Pipeline

### Step 1 : Database Creation

```sql
CREATE DATABASE PAYMENTS_DB;
```

### Step 2 : Data Ingestion

Loaded raw CSV files using:

```sql
BULK INSERT
```

### Step 3 : Staging Layer

Created staging tables:

```text
STG_USERS
STG_TRANSACTIONS
```

Purpose:

* Store raw data
* Maintain data lineage
* Perform validation before transformation

---

## Data Cleaning

### USERS_CLEAN

Performed:

* Data Type Conversion
* Whitespace Removal
* Age Validation
* Join Date Standardization
* Missing Value Handling
* Text Standardization

### TRANSACTIONS_CLEAN

Performed:

* Amount Conversion
* Date Conversion
* Duplicate Validation
* Text Standardization
* Payment Status Validation
* Transaction Consistency Checks

---

## Data Quality Validation

The project includes multiple validation layers.

### Null Value Validation

Validated:

```text
USER_ID
USER_NAME
AGE
JOIN_DATE
TRANSACTION_ID
AMOUNT
TRANSACTION_DATE
```

#### Result

```text
No Null Values Found
```

---

### Duplicate Validation

Validated:

```text
USER_ID
TRANSACTION_ID
```

#### Result

```text
No Duplicate Records Found
```

---

### Invalid Data Checks

Validated:

```text
Negative Amounts
Invalid Ages
Future Dates
Missing Transactions
```

#### Result

```text
No Invalid Records Found
```

---

### Referential Integrity Validation

Validated:

```text
Foreign Key Relationships
Orphan Transactions
```

#### Result

```text
No Referential Integrity Issues Found
```

---

## Database Constraints

### Primary Keys

```text
USERS_CLEAN

PK_USERS


TRANSACTIONS_CLEAN

PK_TRANSACTIONS
```

### Foreign Keys

```text
TRANSACTIONS_CLEAN

FK_TRANSACTIONS_USERS
```

---

## Data Warehouse Design

Implemented dimensional modeling using Star Schema.

### Dimension Tables

#### DIM_USERS

```text
USER_KEY
USER_ID
USER_NAME
AGE
JOIN_DATE
```

#### DIM_DATE

```text
DATE_KEY
FULL_DATE
YEAR
QUARTER
MONTH_NO
MONTH_NAME
DAY_NO
```

### Fact Table

#### FACT_TRANSACTIONS

```text
TRANSACTION_ID
USER_KEY
DATE_KEY
AMOUNT
SERVICE
SERVICE_TYPE
PAYMENT_STATUS
REASON
```

---

## Star Schema Design

```
                 DIM_USERS
                      |
                      |
              FACT_TRANSACTIONS
                      |
                      |
                  DIM_DATE
```

Benefits:

* Faster analytical queries
* Improved reporting performance
* Scalable warehouse design
* Simplified Power BI modeling

---

## Exploratory Data Analysis

The project includes:

### Executive Analysis

* Total Revenue Analysis
* Total Transactions Analysis
* Total Users Analysis
* Average Transaction Analysis
* Success Rate Analysis

### Revenue Analysis

* Monthly Revenue Trend
* Quarterly Revenue Trend
* Service-wise Revenue Analysis
* Revenue Contribution Analysis
* Daily Revenue Analysis

### Customer Analytics

* Top Spending Users
* User Growth Analysis
* Revenue by Age Group
* User Spending Patterns

### Transaction Analytics

* Payment Status Analysis
* Transaction Distribution Analysis
* Failure Reason Analysis
* Service Type Analysis

### Statistical Analysis

* Outlier Detection
* Correlation Analysis
* Revenue Distribution Analysis
* Transaction Pattern Analysis

---

## Business Insights

### Payment Performance

* More than 96% of transactions were successfully completed.
* Failed transactions contributed only a small percentage of total transactions.
* Payment infrastructure demonstrated strong transaction reliability.

#### Business Value

* Indicates excellent payment success rates.
* Improves customer satisfaction.
* Supports business scalability.

---

### Revenue by Service

| Service          | Revenue (Million INR) |
| ---------------- | --------------------- |
| Loans            | 2532.51               |
| Insurance        | 512.92                |
| Money Transfer   | 378.19                |
| Recharge & Bills | 50.69                 |

#### Insights

* Loans generated the highest revenue contribution.
* Insurance emerged as the second-largest revenue source.
* Money Transfers showed high customer engagement.
* Recharge & Bills generated comparatively lower revenue.

---

### Monthly Revenue Analysis

#### Insights

* July recorded the highest monthly revenue.
* February generated the lowest monthly revenue.
* Revenue remained stable throughout the year.

---

### Quarterly Revenue Analysis

| Quarter | Revenue (Million INR) |
| ------- | --------------------- |
| Q1      | 865.03                |
| Q2      | 865.96                |
| Q3      | 877.61                |
| Q4      | 865.72                |

#### Insights

* Revenue distribution remained highly consistent.
* No significant seasonal fluctuations were observed.
* Quarterly performance indicates business stability.

---

### User Spending Analysis

#### Top Spending Customers

```text
Michael Smith
Jennifer Williams
Michael Brown
Christopher Brown
Michael Jones
```

#### Insights

* High-value users generated a significant portion of revenue.
* Premium customer segments provide strong business opportunities.
* Customer segmentation strategies can improve retention initiatives.

---

### Revenue by Age Group

#### Insights

* Users aged 46–60 contributed the highest revenue.
* Users aged 36–45 formed the second-largest segment.
* Younger users showed comparatively lower transaction values.

#### Business Value

* Supports targeted marketing campaigns.
* Enables customer segmentation strategies.
* Improves customer acquisition planning.

---

### Failure Reason Analysis

| Reason              | Failures |
| ------------------- | -------- |
| Server Error        | 3,361    |
| Wrong PIN           | 3,315    |
| Insufficient Amount | 3,304    |

#### Insights

* Server-related failures require infrastructure optimization.
* Customer-related failures indicate opportunities for improving user experience.
* Better transaction handling mechanisms can further improve success rates.

---

## Outlier Analysis

Implemented using the IQR Method.

Performed:

```text
Q1 Calculation
Median Calculation
Q3 Calculation
IQR Calculation
Lower Bound Validation
Upper Bound Validation
Outlier Percentage Analysis
```

### Business Value

* Detects abnormal transaction patterns.
* Helps identify unusually large payments.
* Supports fraud detection initiatives.
* Improves transaction monitoring systems.

---

## Correlation Analysis

Performed across:

```text
Amount
Age
Year
Quarter
Month Number
Day Number
```

Generated:

```text
Correlation Matrix
Heatmap Visualization
```

### Business Value

* Understands variable relationships.
* Identifies transaction behavior patterns.
* Supports advanced analytical modeling.
* Assists in predictive analytics initiatives.

---

## Power BI Dashboard

### Executive Dashboard

KPIs:

* Total Revenue
* Total Users
* Total Transactions
* Average Transaction Value
* Success Rate

Visuals:

* Revenue Trend
* Service-wise Revenue
* Payment Status Analysis
* Revenue Contribution Analysis
* Top Spending Customers

---

### User Analytics Dashboard

Includes:

* Revenue by Age Group
* User Growth Analysis
* Top Spending Users
* Customer Distribution Analysis

---

### Transaction Analytics Dashboard

Includes:

* Monthly Revenue Trend
* Quarterly Revenue Analysis
* Revenue by Service Type
* Failure Reason Analysis
* Daily Revenue Analysis
* Transaction Distribution Analysis

---

## Skills Demonstrated

### Data Engineering

* ETL Processing
* Data Cleaning
* Data Validation
* Data Quality Checks
* Referential Integrity Validation

### SQL Development

* SQL Queries
* Constraints Management
* Aggregations
* Analytical Functions
* Data Warehousing

### Data Analytics

* Exploratory Data Analysis
* Business Analysis
* Statistical Analysis
* Correlation Analysis
* Outlier Detection

### Data Modeling

* Star Schema Design
* Fact & Dimension Modeling
* Data Warehouse Development

### Business Intelligence

* Power BI Dashboard Development
* KPI Reporting
* Interactive Visualizations
* DAX Calculations
* Business Insight Generation

### Tools & Technologies

* SQL Server
* SSMS
* Power BI
* Python
* Pandas
* Matplotlib
* Seaborn
* Git & GitHub

---

## Project Outcome

Successfully designed and implemented an end-to-end payment analytics solution capable of processing 300,000 transactions across 107,658 users. The project demonstrates practical expertise in ETL pipeline development, SQL-based data cleaning, dimensional modeling, statistical analysis, business intelligence reporting, and interactive dashboard creation.

By combining SQL Server, Python, and Power BI, this project showcases industry-ready Data Analyst skills across Data Engineering, Data Analytics, Data Warehousing, and Business Intelligence workflows.

### Core Achievements

* Processed 300,000 payment transactions.
* Implemented end-to-end ETL workflows.
* Designed a Star Schema data warehouse.
* Performed comprehensive business and statistical analysis.
* Built interactive Power BI dashboards.
* Generated actionable business insights from payment data.
* Demonstrated production-style Data Analytics practices.

> **Project Type:** End-to-End Data Analytics Project
> **Domain:** FinTech / Digital Payments Analytics
> **Tools:** SQL Server • Python • Power BI • DAX • Git & GitHub
