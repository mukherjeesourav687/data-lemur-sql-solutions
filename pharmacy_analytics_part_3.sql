-- Problem: Pharmacy Analytics (Part 3)
-- Platform: DataLemur
-- Difficulty: Easy

-- Approach:
-- 1. Group records by manufacturer
-- 2. Calculate total drug sales using SUM(total_sales)
-- 3. Convert sales into millions
-- 4. Format output as "$xx million"
-- 5. Sort by total sales descending and manufacturer ascending

SELECT
    manufacturer,
    CONCAT(
        '$',
        ROUND(SUM(total_sales) / 1000000),
        ' million'
    ) AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer ASC;