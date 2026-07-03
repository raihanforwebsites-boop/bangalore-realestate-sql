# Bangalore Real Estate Analysis — SQL + Python

SQL-based analysis of 13,000+ residential property listings across Bangalore, with results visualized in Python.

## Background

Bangalore is one of India's fastest-growing cities, driven largely by the IT sector. That growth has made it one of the most expensive real estate markets in the country, with property prices varying wildly across localities, BHK types, and builder segments. This project treats that as a data problem — using a structured MySQL database to answer practical questions about pricing, supply concentration, and outliers across the city.

## Tools Used

- **MySQL** — database setup, data import, all analytical queries
- **Python** (pandas, matplotlib, seaborn) — visualizing query results
- **Dataset** — Bengaluru House Price Data, Kaggle (~13,000 listings, cleaned to 13,170 rows)

## Repository Structure

```
├── bangalore_analysis.sql              # all 7 MySQL queries
├── bangalore_realestate_analysis.ipynb # results + visualizations
├── data/
│   └── bangalore_houses_clean.csv      # cleaned dataset
└── README.md
```

## Queries Covered

| # | Query | Purpose |
|---|---|---|
| 1 | Avg price per sqft by locality (Top 20) | Identify premium localities |
| 2 | BHK distribution and pricing | Understand market composition |
| 3 | Localities with most listings | Map supply concentration |
| 4 | Price range by BHK type | Min / avg / max per property size |
| 5 | Most expensive localities by total price | Cross-check with per sqft ranking |
| 6 | Outlier detection via window functions | Find properties far above locality avg |
| 7 | Bathroom count vs price relationship | Test bathroom-price correlation |

## Key Findings

- **Cunningham Road** is the priciest locality at ₹20,632/sqft — a CBD area with old money character, contrasting sharply with IT suburbs
- **Whitefield** has the most listings (532) but doesn't appear in the top price localities — high supply in tech corridors keeps prices relatively moderate
- **2 BHK and 3 BHK** together account for ~78% of all listings, the core of Bangalore's residential market
- Price jumps sharply from 3 BHK (₹111L avg) to 4 BHK (₹272L avg), suggesting 4+ BHK is a distinct luxury segment
- Outlier detection flagged a Raghuvanahalli 1 BHK at ₹1,76,471/sqft — nearly 4.5x the locality average, almost certainly a data entry error

## Data Cleaning

The raw dataset required several cleaning steps before loading into MySQL:
- Removed `society` column (40%+ missing values)
- Extracted numeric BHK from mixed text like "2 BHK", "3 Bedroom"
- Handled `total_sqft` ranges like "1200-1500" by averaging the two bounds
- Filtered implausible values (sqft < 100, price = 0, BHK/bath > 10)
- Added `price_per_sqft` column calculated as `(price × 100,000) / total_sqft`

## How to Run

```bash
pip install pandas matplotlib seaborn jupyter
jupyter notebook bangalore_realestate_analysis.ipynb
```

To replicate the MySQL setup, run `bangalore_analysis.sql` in MySQL Workbench after creating the database and importing `bangalore_houses_clean.csv`.
