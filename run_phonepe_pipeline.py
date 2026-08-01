import pandas as pd
import urllib
from sqlalchemy import create_engine

# =====================================================
# PHONEPE PAYMENTS ANALYTICS AUTOMATION PIPELINE
# =====================================================

print("="*60)
print("PHONEPE PAYMENTS ANALYTICS PIPELINE")
print("="*60)

# -----------------------------------------------------
# SQL SERVER CONNECTION
# -----------------------------------------------------

params = urllib.parse.quote_plus(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=YOUR_SERVER_NAME;"
    "DATABASE=PAYMENTS_DB;"
    "Trusted_Connection=yes;"
    "TrustServerCertificate=yes;"
)

engine = create_engine(
    f"mssql+pyodbc:///?odbc_connect={params}"
)

print("Connected Successfully")

# -----------------------------------------------------
# LOAD CLEAN TABLES
# -----------------------------------------------------

users = pd.read_sql(
    "SELECT * FROM USERS_CLEAN",
    engine
)

transactions = pd.read_sql(
    "SELECT * FROM TRANSACTIONS_CLEAN",
    engine
)

print("Tables Loaded")

# -----------------------------------------------------
# MERGE TABLES
# -----------------------------------------------------

df = transactions.merge(
    users,
    on="USER_ID",
    how="left"
)

print("Merge Completed")

# -----------------------------------------------------
# FEATURE ENGINEERING
# -----------------------------------------------------

df["TRANSACTION_YEAR"] = df["TRANSACTION_DATE"].dt.year
df["TRANSACTION_MONTH"] = df["TRANSACTION_DATE"].dt.month_name()
df["TRANSACTION_DAY"] = df["TRANSACTION_DATE"].dt.day_name()

print("Feature Engineering Completed")

# -----------------------------------------------------
# QUICK KPI
# -----------------------------------------------------

total_users = df["USER_ID"].nunique()
total_transactions = df["TRANSACTION_ID"].nunique()
total_revenue = df["AMOUNT"].sum()
avg_transaction = df["AMOUNT"].mean()

print("\n------------- KPI -------------")
print(f"Users             : {total_users}")
print(f"Transactions      : {total_transactions}")
print(f"Revenue           : ₹{total_revenue:,.2f}")
print(f"Average Amount    : ₹{avg_transaction:,.2f}")

# -----------------------------------------------------
# BUSINESS SUMMARIES
# -----------------------------------------------------

service_summary = (
    df.groupby("SERVICE")["AMOUNT"]
      .sum()
      .sort_values(ascending=False)
      .reset_index()
)

payment_summary = (
    df.groupby("PAYMENT_STATUS")["AMOUNT"]
      .sum()
      .reset_index()
)

monthly_summary = (
    df.groupby("TRANSACTION_MONTH")["AMOUNT"]
      .sum()
      .reset_index()
)

# -----------------------------------------------------
# EXPORT FILES
# -----------------------------------------------------

df.to_csv(
    "PhonePe_Final_Dataset.csv",
    index=False,
    encoding="utf-8-sig"
)

service_summary.to_csv(
    "Service_Summary.csv",
    index=False
)

payment_summary.to_csv(
    "Payment_Status_Summary.csv",
    index=False
)

monthly_summary.to_csv(
    "Monthly_Revenue.csv",
    index=False
)

print("\nCSV Files Exported")

# -----------------------------------------------------
# DATA QUALITY CHECK
# -----------------------------------------------------

print("\n------------- DATA QUALITY -------------")

print("Missing Values")
print(df.isnull().sum())

print("\nDuplicate Rows :", df.duplicated().sum())

# -----------------------------------------------------
# DATASET INFO
# -----------------------------------------------------

print("\nDataset Shape :", df.shape)

print("\nColumns")

for col in df.columns:
    print("-", col)

print("\nPipeline Completed Successfully")

print("="*60)
