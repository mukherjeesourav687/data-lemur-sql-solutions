-- Problem: Card Launch Success
-- Platform: DataLemur
-- Difficulty: Medium

-- Approach:
-- 1. Use ROW_NUMBER() to identify the earliest issued record for each card
-- 2. Partition by card_name
-- 3. Order by issue_year and issue_month ascending
-- 4. Keep only the first launch month record
-- 5. Sort output by issued_amount descending

SELECT
    card_name,
    issued_amount
FROM (
    SELECT
        card_name,
        issued_amount,
        ROW_NUMBER() OVER (
            PARTITION BY card_name
            ORDER BY issue_year, issue_month
        ) AS rn
    FROM monthly_cards_issued
) AS rn
WHERE rn = 1
ORDER BY issued_amount DESC;