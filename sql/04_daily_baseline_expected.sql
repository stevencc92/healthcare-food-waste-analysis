-- Daily baseline (expected scenario): planned vs waste per day
SELECT
  date,
  ROUND(SUM(planned_lbs), 2) AS planned_lbs,
  ROUND(SUM(estimated_waste_lbs), 2) AS estimated_waste_lbs
FROM fact_production_and_waste
WHERE scenario = 'expected'
GROUP BY date
ORDER BY date;