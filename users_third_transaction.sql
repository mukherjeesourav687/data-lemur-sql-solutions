-- Problem: User's Third Transaction
-- Platform: DataLemur
-- Difficulty: Medium

-- Approach:
-- 1. Assign row numbers to each transaction per user
-- 2. Partition by user_id
-- 3. Order transactions by transaction_date
-- 4. Filter only the third transaction
-- 5. Return user_id, spend, and transaction_date

WITH cte AS (
    SELECT
        user_id,
        spend,
        transaction_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY transaction_date
        ) AS rn
    FROM transactions
)

SELECT
    user_id,
    spend,
    transaction_date
FROM cte
WHERE rn = 3;