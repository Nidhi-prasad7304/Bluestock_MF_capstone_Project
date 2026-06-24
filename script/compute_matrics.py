import pandas as pd
from sqlalchemy import create_engine

engine = create_engine(
    "sqlite:///D:/document_curr/Capstone_Project/data/db/bluestock_mf.db"
)

# Load CSVs
df_nav = pd.read_csv(
    "data/processed/nav_history_cleaned.csv"
)

df_transactions = pd.read_csv(
    "data/processed/investor_transactions_cleaned.csv"
)

df_performance = pd.read_csv(
    "data/processed/clean_performance.csv"
)

# Write tables
df_nav.to_sql(
    "fact_nav",
    engine,
    if_exists="replace",
    index=False
)

df_transactions.to_sql(
    "fact_transactions",
    engine,
    if_exists="replace",
    index=False
)

df_performance.to_sql(
    "fact_performance",
    engine,
    if_exists="replace",
    index=False
)

print("All tables loaded successfully!")
