-- Baseline KPIs: total planned production and estimated waste by scenario
SELECT
  scenario,
  ROUND(SUM(planned_lbs), 2) AS total_planned_lbs,
  ROUND(SUM(estimated_waste_lbs), 2) AS total_estimated_waste_lbs,
  ROUND(100.0 * SUM(estimated_waste_lbs) / NULLIF(SUM(planned_lbs), 0), 2) AS waste_pct_of_planned
FROM fact_production_and_waste
GROUP BY scenario
ORDER BY
  CASE scenario
    WHEN 'low' THEN 1
    WHEN 'expected' THEN 2
    WHEN 'high' THEN 3
    ELSE 99
  END;