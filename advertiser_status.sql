-- Problem: Advertiser Status
-- Platform: DataLemur
-- Difficulty: Hard

-- Approach:
-- 1. Use FULL OUTER JOIN logic via LEFT + RIGHT JOIN (since MySQL doesn’t support FULL JOIN)
-- 2. Combine advertiser and daily_pay tables
-- 3. Identify cases:
--    - No payment record → CHURN
--    - Previously CHURN + payment now → RESURRECT
--    - No previous status → NEW
--    - Otherwise → EXISTING
-- 4. Use COALESCE to get user_id from both tables
-- 5. Order by user_id

SELECT 
    COALESCE(a.user_id, d.user_id) AS user_id,
    CASE
        WHEN d.user_id IS NULL THEN 'CHURN'
        WHEN a.status = 'CHURN' THEN 'RESURRECT'
        WHEN a.status IS NULL THEN 'NEW'
        ELSE 'EXISTING'
    END AS new_status
FROM advertiser a
LEFT JOIN daily_pay d 
    ON a.user_id = d.user_id

UNION

SELECT 
    COALESCE(a.user_id, d.user_id) AS user_id,
    CASE
        WHEN d.user_id IS NULL THEN 'CHURN'
        WHEN a.status = 'CHURN' THEN 'RESURRECT'
        WHEN a.status IS NULL THEN 'NEW'
        ELSE 'EXISTING'
    END AS new_status
FROM daily_pay d
LEFT JOIN advertiser a 
    ON a.user_id = d.user_id

ORDER BY user_id;