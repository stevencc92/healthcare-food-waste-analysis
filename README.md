# Healthcare Food Waste Analysis & Metrics Evaluation

SQL-based analytics project exploring hospital meal production data to evaluate food waste patterns, operational variability, and measurement reliability in a healthcare food service environment.

---

## Dashboard Overview

![Hospital Waste Dashboard](Visuals/Hospital%20Waste%20Dashboard.png)

This dashboard summarizes estimated waste levels, production variability, and distribution across hospital units and meal periods.

---

## Key Findings

- Estimated **~4,100 lbs of overproduction waste across a ~90-day window** (~45 lbs/day expected scenario)
- Waste volume appeared **relatively evenly distributed across meal periods**, suggesting systemic overproduction rather than isolated operational errors
- Certain hospital units showed **significantly higher production variance**, indicating potential inefficiencies in buffer policies
- Inconsistent measurement units and logging practices prevented reliable waste tracking without additional modeling

Full interpretation available in:  
- `Analysis/Findings.md`

---

## Project Context

This analysis was inspired by real operational observations in a hospital food service environment.

During meal production, staff must balance:

- regulatory compliance
- patient meal availability
- waste reduction

Because direct waste tracking systems were not available, a partially synthetic dataset was created using real operational patterns and production constraints.

This allowed the project to model realistic decision scenarios while preserving operational logic between units, meal periods, and production buffers.

---

## Tools Used

- SQL (SQLite)
- Excel
- Tableau

---

## Assumptions & Limitations

Because direct waste tracking was unavailable, the analysis uses modeled estimates derived from observed production behavior.

Key assumptions and limitations are documented here:

`Assumptions_and_Limitations.md`

---

## Project Focus

Evaluating the reliability of operational metrics and exploring decision-support insights in environments with imperfect data.
