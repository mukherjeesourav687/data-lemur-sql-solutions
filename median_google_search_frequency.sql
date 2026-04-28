-- 🐵 DataLemur: Median Google Search Frequency

/*
Problem:
Find the median number of searches made by users.
The data is already aggregated, so we must compute the median using cumulative frequency.

Table: search_frequency
Columns:
- searches (integer)
- num_users (integer)
*/

WITH cte AS (
    SELECT 
        searches,
        num_users,
        SUM(num_users) OVER (ORDER BY searches) AS cum_users,
        SUM(num_users) OVER () AS total_users
    FROM search_frequency
)

SELECT 
    ROUND(AVG(searches), 1) AS median
FROM cte
WHERE 
    cum_users >= total_users / 2
    AND cum_users - num_users < total_users / 2;