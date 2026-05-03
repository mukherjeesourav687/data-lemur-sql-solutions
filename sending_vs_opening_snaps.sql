Day 63 - Sending vs. Opening Snaps (DataLemur)

Problem:
Calculate the percentage of time spent sending vs. opening snaps,
grouped by age group. Round the results to 2 decimal places.

Approach:

• Joined activities table with age_breakdown to get age groups
• Filtered only relevant activities ('send', 'open')
• Used conditional aggregation with CASE WHEN
• Calculated total time spent on both activities
• Computed percentages using:
  - send time / total time
  - open time / total time
• Multiplied by 100.0 to avoid integer division
• Rounded results to 2 decimal places
• Grouped data by age_bucket

SQL Solution:

SELECT 
    ab.age_bucket,
    ROUND(
        100.0 * SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) /
        SUM(CASE WHEN a.activity_type IN ('send', 'open') THEN a.time_spent ELSE 0 END),
    2) AS send_perc,
    
    ROUND(
        100.0 * SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) /
        SUM(CASE WHEN a.activity_type IN ('send', 'open') THEN a.time_spent ELSE 0 END),
    2) AS open_perc

FROM activities a
JOIN age_breakdown ab 
    ON a.user_id = ab.user_id
WHERE a.activity_type IN ('send', 'open')
GROUP BY ab.age_bucket;

Key Learning:

Conditional aggregation is a powerful way to calculate segmented metrics.
Also reinforced the importance of handling division carefully to avoid incorrect percentages.

Real-world Insight:

This type of analysis is used in:
• User behaviour analytics
• Product engagement tracking
• Feature usage breakdown

Understanding how users spend time helps teams optimise product experience.