-- Problem: Marketing Touch Streak
-- Platform: DataLemur
-- Difficulty: Hard

-- Approach:
-- 1. Aggregate touches weekly per contact
-- 2. Use DENSE_RANK to create sequence
-- 3. Identify consecutive weeks using gap-and-island logic
-- 4. Filter contacts with streak >= 3 weeks
-- 5. Ensure at least one 'trial_request' exists
-- 6. Return corresponding email IDs

WITH weekly_touches AS (
    SELECT 
        contact_id,
        YEARWEEK(event_date, 1) AS touch_week,
        MAX(CASE WHEN event_type = 'trial_request' THEN 1 ELSE 0 END) AS has_trial
    FROM marketing_touches
    GROUP BY contact_id, YEARWEEK(event_date, 1)
),

ranked AS (
    SELECT 
        contact_id,
        touch_week,
        DENSE_RANK() OVER (PARTITION BY contact_id ORDER BY touch_week) AS rk
    FROM weekly_touches
),

islands AS (
    SELECT 
        contact_id,
        (touch_week - rk) AS grp,
        COUNT(*) AS consecutive_weeks
    FROM ranked
    GROUP BY contact_id, (touch_week - rk)
),

qualified AS (
    SELECT contact_id
    FROM islands
    WHERE consecutive_weeks >= 3
)

SELECT c.email
FROM crm_contacts c
WHERE c.contact_id IN (
    SELECT contact_id FROM qualified
)
AND c.contact_id IN (
    SELECT contact_id 
    FROM marketing_touches 
    WHERE event_type = 'trial_request'
)
ORDER BY c.email;