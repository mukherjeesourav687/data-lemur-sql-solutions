Day 63 - Server Utilization Time (DataLemur)

Problem:
Calculate the total time that the fleet of servers was running.
The result should be in full days.

Approach:

• Used a CTE (uptime) to structure the data
• Applied LEAD() window function to get the next timestamp (stop_time)
• Partitioned by server_id to track each server separately
• Calculated time difference using TIMESTAMPDIFF in seconds
• Converted seconds to days by dividing by 86400
• Used FLOOR() to return only full days
• Filtered only 'start' sessions to correctly measure uptime

SQL Solution:

WITH uptime AS (
    SELECT
        server_id,
        status_time,
        LEAD(status_time) OVER (
            PARTITION BY server_id 
            ORDER BY status_time
        ) AS stop_time,
        session_status
    FROM server_utilization
)

SELECT
    FLOOR(SUM(TIMESTAMPDIFF(SECOND, status_time, stop_time)) / 86400) AS total_uptime_days
FROM uptime
WHERE session_status = 'start';

Key Learning:

Window functions like LEAD() are extremely useful for pairing sequential events.
This helps in solving time-based problems efficiently without complex joins.

Real-world Insight:

This type of logic is used in:
• Server uptime monitoring
• System performance tracking
• IoT and device activity analysis

Breaking event logs into meaningful durations is a key skill in data analytics.