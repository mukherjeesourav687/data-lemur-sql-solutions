Day 63 - Spotify Streaming History (DataLemur)

Problem:
Calculate the cumulative count of song plays for each user and song,
including both historical data and current week data up to August 4th, 2022.
Sort the results in descending order of song plays.

Approach:

• Combined songs_history and songs_weekly using UNION ALL
• Selected historical data directly from songs_history
• Aggregated weekly data using COUNT(*) for each user and song
• Filtered weekly data up to '2022-08-04 23:59:59'
• Grouped combined data by user_id and song_id
• Calculated total song plays using SUM()
• Sorted results in descending order of song plays

SQL Solution:

SELECT
    user_id,
    song_id,
    SUM(song_plays) AS song_plays
FROM (
    SELECT user_id, song_id, song_plays
    FROM songs_history

    UNION ALL

    SELECT
        user_id,
        song_id,
        COUNT(*) AS song_plays
    FROM songs_weekly
    WHERE listen_time <= '2022-08-04 23:59:59'
    GROUP BY user_id, song_id
) t
GROUP BY user_id, song_id
ORDER BY song_plays DESC;

Key Learning:

Combining datasets using UNION ALL helps preserve all records without losing duplicates.
Also learned how to merge historical and incremental data effectively.

Real-world Insight:

This type of analysis is used in:
• Music streaming platforms
• User engagement tracking
• Recommendation systems

Understanding cumulative behaviour helps in building personalised experiences.