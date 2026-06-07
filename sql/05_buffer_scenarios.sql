-- buffer_scenarios.sql
-- Compares estimated overproduction waste across three operational scenarios:
-- low (5%), expected (10%), and high (18%) waste rates.
-- Source tables: estimated_waste, waste_scenarios, production_assumptions

-- ─────────────────────────────────────────────────────────────
-- 1. Total waste projection by scenario (90-day window)
-- ─────────────────────────────────────────────────────────────

SELECT
    scenario,
    ROUND(waste_pct * 100, 0) || '%'          AS waste_rate,
    ROUND(SUM(estimated_waste_lbs), 1)         AS total_waste_lbs,
    ROUND(SUM(estimated_waste_lbs) / 90.0, 1) AS avg_daily_waste_lbs
FROM estimated_waste
GROUP BY scenario, waste_pct
ORDER BY waste_pct;

-- ─────────────────────────────────────────────────────────────
-- 2. Scenario range: gap between low and high projections
-- ─────────────────────────────────────────────────────────────

SELECT
    ROUND(MAX(CASE WHEN scenario = 'low'      THEN total END), 1) AS low_total_lbs,
    ROUND(MAX(CASE WHEN scenario = 'expected' THEN total END), 1) AS expected_total_lbs,
    ROUND(MAX(CASE WHEN scenario = 'high'     THEN total END), 1) AS high_total_lbs,
    ROUND(
        MAX(CASE WHEN scenario = 'high' THEN total END) -
        MAX(CASE WHEN scenario = 'low'  THEN total END),
    1) AS scenario_range_lbs
FROM (
    SELECT scenario, SUM(estimated_waste_lbs) AS total
    FROM estimated_waste
    GROUP BY scenario
);

-- ─────────────────────────────────────────────────────────────
-- 3. Waste by unit, broken out across all three scenarios
-- Shows which units drive the most exposure under each scenario
-- ─────────────────────────────────────────────────────────────

SELECT
    unit,
    ROUND(MAX(CASE WHEN scenario = 'low'      THEN unit_waste END), 1) AS low_lbs,
    ROUND(MAX(CASE WHEN scenario = 'expected' THEN unit_waste END), 1) AS expected_lbs,
    ROUND(MAX(CASE WHEN scenario = 'high'     THEN unit_waste END), 1) AS high_lbs,
    ROUND(
        MAX(CASE WHEN scenario = 'high' THEN unit_waste END) -
        MAX(CASE WHEN scenario = 'low'  THEN unit_waste END),
    1) AS low_to_high_range_lbs
FROM (
    SELECT unit, scenario, SUM(estimated_waste_lbs) AS unit_waste
    FROM estimated_waste
    GROUP BY unit, scenario
)
GROUP BY unit
ORDER BY expected_lbs DESC;

-- ─────────────────────────────────────────────────────────────
-- 4. Weekly waste trend by scenario
-- Surfaces whether overproduction is stable or drifting over time
-- ─────────────────────────────────────────────────────────────

SELECT
    strftime('%Y-W%W', date)                   AS week,
    scenario,
    ROUND(SUM(estimated_waste_lbs), 1)         AS weekly_waste_lbs,
    ROUND(SUM(estimated_waste_lbs) / 7.0, 1)  AS avg_daily_waste_lbs
FROM estimated_waste
GROUP BY week, scenario
ORDER BY week, scenario;
