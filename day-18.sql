-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH first_scores AS (
    SELECT subject, score AS first_score
    FROM daily_quiz_scores
    WHERE (subject, quiz_date) IN (
        SELECT subject, MIN(quiz_date)
        FROM daily_quiz_scores
        GROUP BY subject
    )
),
last_scores AS (
    SELECT subject, score AS last_score
    FROM daily_quiz_scores
    WHERE (subject, quiz_date) IN (
        SELECT subject, MAX(quiz_date)
        FROM daily_quiz_scores
        GROUP BY subject
    )
)
SELECT
    f.subject,
    f.first_score,
    l.last_score
FROM first_scores f
JOIN last_scores l
    ON f.subject = l.subject
ORDER BY f.subject;
