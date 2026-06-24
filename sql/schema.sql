-- ==========================================
-- Mutual Fund Analytics Star Schema
-- ==========================================

PRAGMA foreign_keys = ON;

-- ==========================================
-- DIMENSION TABLES
-- ==========================================

CREATE TABLE dim_fund (
    amfi_code TEXT PRIMARY KEY,
    fund_house TEXT NOT NULL,
    scheme_name TEXT NOT NULL,
    category TEXT,
    sub_category TEXT,
    expense_ratio REAL
);

CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY,
    date DATE UNIQUE NOT NULL,
    year INTEGER,
    month INTEGER,
    quarter INTEGER,
    day INTEGER,
    weekday INTEGER,
    is_weekday INTEGER
);

-- ==========================================
-- FACT NAV
-- ==========================================

CREATE TABLE fact_nav (
    nav_id INTEGER PRIMARY KEY AUTOINCREMENT,
    amfi_code TEXT NOT NULL,
    date_id INTEGER NOT NULL,
    nav REAL NOT NULL,
    daily_return_pct REAL,

    FOREIGN KEY (amfi_code)
        REFERENCES dim_fund(amfi_code),

    FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id),

    UNIQUE(amfi_code, date_id)
);

-- ==========================================
-- FACT TRANSACTIONS
-- ==========================================

CREATE TABLE fact_transactions (
    tx_id INTEGER PRIMARY KEY AUTOINCREMENT,
    investor_id TEXT NOT NULL,
    amfi_code TEXT NOT NULL,
    date_id INTEGER NOT NULL,

    transaction_type TEXT,
    amount REAL,
    units REAL,
    nav REAL,
    kyc_status TEXT,

    FOREIGN KEY (amfi_code)
        REFERENCES dim_fund(amfi_code),

    FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id)
);

-- ==========================================
-- FACT PERFORMANCE
-- ==========================================

CREATE TABLE fact_performance (
    performance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    amfi_code TEXT NOT NULL,
    as_of_date INTEGER NOT NULL,

    return_1yr REAL,
    return_3yr REAL,
    return_5yr REAL,

    sharpe REAL,
    alpha REAL,
    beta REAL,
    volatility REAL,
    max_dd REAL,

    FOREIGN KEY (amfi_code)
        REFERENCES dim_fund(amfi_code),

    FOREIGN KEY (as_of_date)
        REFERENCES dim_date(date_id)
);

-- ==========================================
-- FACT AUM
-- ==========================================

CREATE TABLE fact_aum (
    aum_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fund_house TEXT NOT NULL,
    date_id INTEGER NOT NULL,

    aum_crore REAL,
    num_schemes INTEGER,

    FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id)
);

-- ==========================================
-- INDEXES
-- ==========================================

CREATE INDEX idx_nav_amfi
ON fact_nav(amfi_code);

CREATE INDEX idx_nav_date
ON fact_nav(date_id);

CREATE INDEX idx_txn_amfi
ON fact_transactions(amfi_code);

CREATE INDEX idx_txn_date
ON fact_transactions(date_id);

CREATE INDEX idx_perf_amfi
ON fact_performance(amfi_code);

CREATE INDEX idx_aum_date
ON fact_aum(date_id);
