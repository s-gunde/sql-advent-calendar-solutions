-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

-- Step 1: Count messages per user per day
WITH daily_counts AS (
    SELECT
        sender_id,
        DATE(sent_at) AS message_date,
        COUNT(*) AS message_count
    FROM npn_messages
    GROUP BY sender_id, DATE(sent_at)
),
-- Step 2: Find the max messages per day
max_counts AS (
    SELECT
        message_date,
        MAX(message_count) AS max_count
    FROM daily_counts
    GROUP BY message_date
)
-- Step 3: Get the users with max messages
SELECT
    dc.message_date,
    u.user_name,
    dc.message_count
FROM daily_counts dc
JOIN max_counts mc
    ON dc.message_date = mc.message_date
   AND dc.message_count = mc.max_count
JOIN npn_users u
    ON dc.sender_id = u.user_id
ORDER BY dc.message_date, u.user_name;
