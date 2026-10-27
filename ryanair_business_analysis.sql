
-- ============================================================
-- RYANAIR FLIGHT OPERATIONS ANALYTICS
-- SQL Business Analysis | MySQL 8.0+
-- Period: July 2025 - July 2026
-- ============================================================

CREATE DATABASE IF NOT EXISTS ryanair_project;
USE ryanair_project;


-- 01. Monthly Flight Activity
-- How does recorded flight activity vary by month?

SELECT
    YEAR(dof) AS flight_year,
    MONTH(dof) AS flight_month,
    MONTHNAME(dof) AS month_name,
    COUNT(*) AS total_flight_records
FROM ryanair_flights
WHERE dof IS NOT NULL
GROUP BY
    YEAR(dof),
    MONTH(dof),
    MONTHNAME(dof)
ORDER BY
    flight_year,
    flight_month;


-- 02. Flight Activity by Day of the Week
-- Which weekdays have the highest recorded flight counts?

SELECT
    days_of_the_week,
    COUNT(*) AS total_flight_records
FROM ryanair_flights
WHERE days_of_the_week IS NOT NULL
GROUP BY days_of_the_week
ORDER BY total_flight_records DESC;


-- 03. Top 10 Departure Airports
-- Which departure airports have the most recorded flights?

SELECT
    adep,
    COUNT(*) AS total_flight_records
FROM ryanair_flights
WHERE adep IS NOT NULL
GROUP BY adep
ORDER BY total_flight_records DESC
LIMIT 10;


-- 04. Top 10 Destination Airports
-- Which destination airports have the most recorded flights?

SELECT
    ades,
    COUNT(*) AS total_flight_records
FROM ryanair_flights
WHERE ades IS NOT NULL
GROUP BY ades
ORDER BY total_flight_records DESC
LIMIT 10;


-- 05. Top 10 Flight Routes
-- Which directional routes have the most recorded flights?

SELECT
    route,
    COUNT(*) AS total_flight_records
FROM ryanair_flights
WHERE route IS NOT NULL
GROUP BY route
ORDER BY total_flight_records DESC
LIMIT 10;


-- 06. Aircraft Model Distribution
-- Which aircraft models appear most frequently?

SELECT
    aircraft_model_clean,
    COUNT(*) AS total_flight_records
FROM ryanair_flights
GROUP BY aircraft_model_clean
ORDER BY total_flight_records DESC;


-- 07. Average Daily Activity: Weekdays vs Weekends
-- Which day type has higher average daily recorded activity?

WITH daily_flights AS (
    SELECT
        DATE(dof) AS flight_date,
        day_type,
        COUNT(*) AS total_flight_records
    FROM ryanair_flights
    WHERE dof IS NOT NULL
      AND day_type IS NOT NULL
    GROUP BY DATE(dof), day_type
),
average_flights AS (
    SELECT
        day_type,
        ROUND(AVG(total_flight_records), 2) AS avg_daily_flights
    FROM daily_flights
    GROUP BY day_type
)
SELECT
    day_type,
    avg_daily_flights,
    RANK() OVER (
        ORDER BY avg_daily_flights DESC
    ) AS activity_rank
FROM average_flights
ORDER BY activity_rank;


-- 08. Month-over-Month Flight Activity
-- Which months show the largest changes in recorded activity?

WITH monthly_flights AS (
    SELECT
        YEAR(dof) AS flight_year,
        MONTH(dof) AS flight_month,
        COUNT(*) AS total_flight_records
    FROM ryanair_flights
    WHERE dof IS NOT NULL
    GROUP BY YEAR(dof), MONTH(dof)
),
monthly_comparison AS (
    SELECT
        flight_year,
        flight_month,
        total_flight_records,
        LAG(total_flight_records) OVER (
            ORDER BY flight_year, flight_month
        ) AS previous_month_records
    FROM monthly_flights
)
SELECT
    flight_year,
    flight_month,
    total_flight_records,
    previous_month_records,
    total_flight_records - previous_month_records AS flight_change
FROM monthly_comparison
ORDER BY flight_year, flight_month;


-- 09. Monthly Aircraft Model Share
-- How does each aircraft model's share change over time?

WITH monthly_flights AS (
    SELECT
        YEAR(dof) AS flight_year,
        MONTH(dof) AS flight_month,
        aircraft_model_clean,
        COUNT(*) AS total_flight_records
    FROM ryanair_flights
    WHERE dof IS NOT NULL
    GROUP BY
        YEAR(dof),
        MONTH(dof),
        aircraft_model_clean
)
SELECT
    flight_year,
    flight_month,
    aircraft_model_clean,
    total_flight_records,
    ROUND(
        total_flight_records * 100.0 /
        SUM(total_flight_records) OVER (
            PARTITION BY flight_year, flight_month
        ),
        2
    ) AS percentage_share
FROM monthly_flights
ORDER BY
    flight_year,
    flight_month,
    percentage_share DESC;


-- 10. Consistently High-Ranking Departure Airports
-- Which airports rank among the top five most frequently?

WITH monthly_flights AS (
    SELECT
        YEAR(dof) AS flight_year,
        MONTH(dof) AS flight_month,
        adep,
        COUNT(*) AS total_flight_records
    FROM ryanair_flights
    WHERE dof IS NOT NULL
      AND adep IS NOT NULL
    GROUP BY
        YEAR(dof),
        MONTH(dof),
        adep
),
ranked_airports AS (
    SELECT
        flight_year,
        flight_month,
        adep,
        RANK() OVER (
            PARTITION BY flight_year, flight_month
            ORDER BY total_flight_records DESC
        ) AS airport_rank
    FROM monthly_flights
)
SELECT
    adep,
    COUNT(*) AS months_in_top_5
FROM ranked_airports
WHERE airport_rank <= 5
GROUP BY adep
ORDER BY months_in_top_5 DESC;
