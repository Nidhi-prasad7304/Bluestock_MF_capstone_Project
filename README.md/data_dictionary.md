# Data Dictionary

## Bluestock Mutual Fund Analytics Capstone

### Dataset 1: nav_history_cleaned.csv

| Column Name | Data Type | Description                                          | Source              |
| ----------- | --------- | ---------------------------------------------------- | ------------------- |
| amfi_code   | INTEGER   | Unique AMFI scheme identifier                        | NAV History Dataset |
| date        | DATE      | NAV reporting date                                   | NAV History Dataset |
| nav         | FLOAT     | Net Asset Value of the mutual fund on the given date | NAV History Dataset |

---

### Dataset 2: investor_transactions_cleaned.csv

| Column Name        | Data Type | Description                                    | Source                        |
| ------------------ | --------- | ---------------------------------------------- | ----------------------------- |
| investor_id        | TEXT      | Unique investor identifier                     | Investor Transactions Dataset |
| transaction_date   | DATE      | Date of transaction                            | Investor Transactions Dataset |
| amfi_code          | INTEGER   | Mutual fund scheme identifier                  | Investor Transactions Dataset |
| transaction_type   | TEXT      | Type of transaction (SIP, Lumpsum, Redemption) | Investor Transactions Dataset |
| amount_inr         | FLOAT     | Transaction amount in INR                      | Investor Transactions Dataset |
| state              | TEXT      | Investor state                                 | Investor Transactions Dataset |
| city               | TEXT      | Investor city                                  | Investor Transactions Dataset |
| city_tier          | TEXT      | City classification (Tier 1, Tier 2, Tier 3)   | Investor Transactions Dataset |
| age_group          | TEXT      | Investor age bracket                           | Investor Transactions Dataset |
| gender             | TEXT      | Investor gender                                | Investor Transactions Dataset |
| annual_income_lakh | FLOAT     | Annual income in lakhs INR                     | Investor Transactions Dataset |
| payment_mode       | TEXT      | Transaction payment mode                       | Investor Transactions Dataset |
| kyc_status         | TEXT      | KYC verification status                        | Investor Transactions Dataset |

---

### Dataset 3: clean_performance.csv

| Column Name          | Data Type | Description                                          | Source              |
| -------------------- | --------- | ---------------------------------------------------- | ------------------- |
| amfi_code            | INTEGER   | Unique mutual fund identifier                        | Performance Dataset |
| scheme_name          | TEXT      | Name of mutual fund scheme                           | Performance Dataset |
| fund_house           | TEXT      | Asset Management Company (AMC)                       | Performance Dataset |
| category             | TEXT      | Fund category                                        | Performance Dataset |
| plan                 | TEXT      | Direct/Regular Plan                                  | Performance Dataset |
| return_1yr_pct       | FLOAT     | 1-year return (%)                                    | Performance Dataset |
| return_3yr_pct       | FLOAT     | 3-year annualized return (%)                         | Performance Dataset |
| return_5yr_pct       | FLOAT     | 5-year annualized return (%)                         | Performance Dataset |
| benchmark_3yr_pct    | FLOAT     | Benchmark return over 3 years (%)                    | Performance Dataset |
| alpha                | FLOAT     | Risk-adjusted excess return                          | Performance Dataset |
| beta                 | FLOAT     | Market sensitivity measure                           | Performance Dataset |
| sharpe_ratio         | FLOAT     | Risk-adjusted performance metric                     | Performance Dataset |
| sortino_ratio        | FLOAT     | Downside risk-adjusted return metric                 | Performance Dataset |
| std_dev_ann_pct      | FLOAT     | Annualized standard deviation (%)                    | Performance Dataset |
| max_drawdown_pct     | FLOAT     | Maximum observed portfolio decline (%)               | Performance Dataset |
| aum_crore            | FLOAT     | Assets Under Management (₹ Crore)                    | Performance Dataset |
| expense_ratio_pct    | FLOAT     | Annual expense ratio (%)                             | Performance Dataset |
| morningstar_rating   | INTEGER   | Morningstar rating score                             | Performance Dataset |
| risk_grade           | TEXT      | Risk classification (Low, Moderate, High, Very High) | Performance Dataset |
| Negative_Sharpe_Flag | TEXT      | Indicates negative Sharpe ratio (Yes/No)             | Derived Feature     |
| Expense_Ratio_Valid  | TEXT      | Expense ratio validation flag                        | Derived Feature     |

---

# Database Tables

| Table Name        | Source Dataset                    | Purpose                                    |
| ----------------- | --------------------------------- | ------------------------------------------ |
| fact_nav          | nav_history_cleaned.csv           | Historical NAV tracking and trend analysis |
| fact_transactions | investor_transactions_cleaned.csv | Investor behavior and transaction analysis |
| fact_performance  | clean_performance.csv             | Fund performance and risk analysis         |

---

# Key Relationships

| Parent Column              | Child Column                | Relationship |
| -------------------------- | --------------------------- | ------------ |
| fact_performance.amfi_code | fact_nav.amfi_code          | One-to-Many  |
| fact_performance.amfi_code | fact_transactions.amfi_code | One-to-Many  |

---

# Data Volume

| Dataset           | Approximate Records |
| ----------------- | ------------------- |
| fact_nav          | ~46,000             |
| fact_transactions | ~32,000             |
| fact_performance  | ~40                 |
