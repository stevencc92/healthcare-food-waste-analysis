-- Unit ranking by estimated waste (expected scenario)
SELECT
  unit,
  ROUND(SUM(planned_lbs), 2)         AS planned_lbs,
  ROUND(SUM(estimated_waste_lbs), 2) AS estimated_waste_lbs
FROM fact_production_and_waste
WHERE scenario = 'expected'
GROUP BY unit
ORDER BY estimated_waste_lbs DESC;