# SQL Data Analysis

## Overview
This repository contains a SQL-based exploratory data analysis project focused on layoffs data. It includes a SQLite database (`world_layoffs.db`) and a SQL script (`Exploratory_Data_Analysis.sql`) that demonstrates data profiling, cleaning, and insight generation using SQL queries.

This project highlights a methodical approach to:
- Inspecting raw data structure and quality
- Aggregating and ranking metrics by company, industry, country, year, and stage
- Identifying patterns in layoffs volume and timeline
- Using SQLite for reproducible analysis and data validation

## Files
- `Exploratory_Data_Analysis.sql` - SQL script containing the exploratory queries and analysis steps.
- `world_layoffs.db` - SQLite database file with the loaded dataset and staging table.

## Key Analytical Questions Covered
- What are the maximum layoffs recorded in the dataset?
- Which companies have laid off 100% of their workforce?
- Which companies and industries account for the largest total layoffs?
- How do layoffs vary by country and by year?
- Which stage of funding experienced the highest layoff totals?
- How does the cumulative layoff trend evolve month-over-month?
- Which companies ranked highest in layoffs each year?
- What are the top 5 companies with the largest yearly layoffs?

## Highlights of the SQL Workflow
- Data inspection using `SELECT *` and aggregate summaries
- Cleaning and profiling through `GROUP BY`, `ORDER BY`, and window functions
- Temporal analysis using `strftime('%Y', date)` for year extraction
- Rolling totals and ranking with window functions such as `SUM() OVER()` and `DENSE_RANK()`

## How to Use
1. Open `Exploratory_Data_Analysis.sql` in your SQL editor.
2. Connect to the SQLite database file `world_layoffs.db`.
3. Execute the queries step-by-step to reproduce the exploratory analysis and visualizations.

## Notes
- The script is designed for SQLite-compatible SQL syntax.
- The dataset is explored from a staging table named `layoffs_staging2`.
- Queries are structured to support both high-level summary and detailed company-level breakdowns.

## Recommended Next Steps
- Build visualizations from the summary results for stakeholder reporting.
- Expand the analysis to include sector-specific and geographic trend comparisons.
