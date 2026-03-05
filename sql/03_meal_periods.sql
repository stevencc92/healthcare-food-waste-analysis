-- Estimated waste by meal (expected scenario)
SELECT
  meal,
  ROUND(SUM(planned_lbs), 2) AS planned_lbs,
  ROUND(SUM(estimated_waste_lbs), 2) AS estimated_waste_lbs,
  ROUND(100.0 * SUM(estimated_waste_lbs) / NULLIF(SUM(planned_lbs), 0), 2) AS waste_pct_of_planned
FROM fact_production_and_waste
WHERE scenario = 'expected'
GROUP BY meal
ORDER BY estimated_waste_lbs DESC;