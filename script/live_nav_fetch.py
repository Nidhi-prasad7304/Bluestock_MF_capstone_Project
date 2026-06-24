import requests
import pandas as pd
import os

# API URL for HDFC Top 100 Fund - Direct Plan - Growth
url = "https://api.mfapi.in/mf/125497"

# Fetch data
response = requests.get(url)
response.raise_for_status()

# Parse JSON
data = response.json()

# Extract NAV history
nav_df = pd.DataFrame(data["data"])

# Add scheme metadata to each row
nav_df["scheme_code"] = data["meta"]["scheme_code"]
nav_df["scheme_name"] = data["meta"]["scheme_name"]
nav_df["fund_house"] = data["meta"]["fund_house"]

# Create output directory if needed
os.makedirs("data/raw", exist_ok=True)

# Save CSV
output_file = "data/raw/hdfc_top100_nav.csv"
nav_df.to_csv(output_file, index=False)

print(f"Saved {len(nav_df)} records to {output_file}")
print(nav_df.head())


import requests
import pandas as pd
import os

# Mutual Fund Scheme Codes
schemes = {
    "SBI_Bluechip": 119551,
    "ICICI_Bluechip": 120503,
    "Nippon_Large_Cap": 118632,
    "Axis_Bluechip": 119092,
    "Kotak_Bluechip": 120841
}

# Create output directory
os.makedirs("data/raw", exist_ok=True)

for scheme_name, scheme_code in schemes.items():
    url = f"https://api.mfapi.in/mf/{scheme_code}"

    try:
        response = requests.get(url)
        response.raise_for_status()

        data = response.json()

        # Convert NAV history to DataFrame
        df = pd.DataFrame(data["data"])

        # Add metadata
        df["scheme_code"] = scheme_code
        df["scheme_name"] = data["meta"]["scheme_name"]

        # Save CSV
        file_path = f"data/raw/{scheme_name.lower()}_nav.csv"
        df.to_csv(file_path, index=False)

        print(f"✓ Saved {scheme_name} -> {file_path}")
        print(f"  Shape: {df.shape}")

    except Exception as e:
        print(f"✗ Error fetching {scheme_name}: {e}")