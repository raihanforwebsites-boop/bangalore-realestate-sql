-- Bangalore Real Estate Analysis
-- Dataset: Bengaluru House Price Data (Kaggle)

USE bangalore_realestate;

-- Query 1: Average price per sqft by locality (Top 20)
SELECT 
    location,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft,
    COUNT(*) AS total_listings
FROM house_prices
GROUP BY location
HAVING COUNT(*) > 10
ORDER BY avg_price_per_sqft DESC
LIMIT 20;

-- Query 2: BHK distribution
SELECT 
    bhk,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price_lakhs,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft
FROM house_prices
GROUP BY bhk
ORDER BY bhk;

-- Query 3: Localities with most listings
SELECT 
    location,
    COUNT(*) AS total_listings
FROM house_prices
GROUP BY location
ORDER BY total_listings DESC
LIMIT 20;

-- Query 4: Price range by BHK type
SELECT
    bhk,
    ROUND(AVG(price), 2) AS avg_price_lakhs,
    ROUND(MIN(price), 2) AS min_price_lakhs,
    ROUND(MAX(price), 2) AS max_price_lakhs,
    COUNT(*) AS total_listings
FROM house_prices
GROUP BY bhk
ORDER BY bhk;

-- Query 5: Most expensive localities by average total price
SELECT
    location,
    ROUND(AVG(price), 2) AS avg_price_lakhs,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft,
    COUNT(*) AS total_listings
FROM house_prices
GROUP BY location
HAVING COUNT(*) > 10
ORDER BY avg_price_lakhs DESC
LIMIT 20;

-- Query 6: Price per sqft outlier detection
SELECT
    location,
    bhk,
    total_sqft,
    price,
    price_per_sqft,
    ROUND(AVG(price_per_sqft) OVER (PARTITION BY location), 2) AS avg_locality_price_per_sqft,
    ROUND(price_per_sqft - AVG(price_per_sqft) OVER (PARTITION BY location), 2) AS deviation_from_avg
FROM house_prices
ORDER BY deviation_from_avg DESC
LIMIT 20;

-- Query 7: Bathroom vs price relationship
SELECT
    bath,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price_lakhs,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft
FROM house_prices
GROUP BY bath
ORDER BY bath;