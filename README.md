#  SQL Case Study: Data Mart Analysis

##  Introduction
This case study focuses on analyzing the sales performance of **Data Mart**, a venture that adopted sustainable packaging in June 2020. The goal was to evaluate sales trends and performance across regions, platforms, and demographic changes.

Using SQL (MySQL Workbench), I performed **data cleansing** and answered **7 business questions** through structured queries on the `weekly_sales` dataset.

---

##  Schema Used: `weekly_sales`

| Column Name      | Data Type  |
|------------------|------------|
| week_date        | DATE       |
| region           | VARCHAR(20)|
| platform         | VARCHAR(20)|
| segment          | VARCHAR(10)|
| customer         | VARCHAR(20)|
| transactions     | INT        |
| sales            | INT        |

---

##  Part A: Data Cleaning Steps

Performed all transformations in a single SQL query and created a new table `clean_weekly_sales`. Key operations included:

- Extracted `week_number`, `month_number`, and `calendar_year` from `week_date`
- Mapped segment codes to `age_band` (e.g., '1' = Young Adults)
- Derived `demographic` based on segment prefix ('C' = Couples, 'F' = Families)
- Replaced all `NULL` and empty values with `'unknown'`
- Created a new column `avg_transaction` as `sales ÷ transactions` (rounded to 2 decimal places)

---

## Part B: Data Exploration

The following business questions were analyzed using advanced SQL queries:

## 1. Missing Week Numbers

Identified gaps in weekly data to validate data completeness.

Result:
Sales data was available for only 6 weeks (Weeks 30–35), indicating partial-year coverage and limiting seasonality analysis.

## 2. Total Transactions by Year

Summed total transactions grouped by calendar year.

Result:

2018: 346,406,460 transactions

2019: 365,639,285 transactions

2020: 375,813,651 transactions

This shows a consistent year-over-year increase in transaction volume.

## 3. Monthly Sales by Region

Analyzed regional sales performance across months.

Result:
Oceania emerged as the top-performing region across all months, followed by Africa and Asia, indicating strong regional demand concentration.

## 4. Total Transactions by Platform

Compared transaction volume across sales platforms.

Result:

Retail: 1,081,934,227 transactions

Shopify: 5,925,169 transactions

Retail clearly dominates overall transaction activity.

## 5. Monthly Sales Percentage – Retail vs Shopify

Calculated platform-wise sales contribution using CTEs and CASE logic.

Result:
Retail consistently contributed ~97% of monthly sales, while Shopify showed gradual growth from ~2.1% to ~3.4% over time.

## 6. Sales Percentage by Demographic (Yearly)

Used window functions to analyze demographic contribution by year.

Result:
Families and Couples contributed the highest sales share, with Couples’ contribution increasing from 30.4% (2018) to 36.1% (2020).

## 7. Top-Contributing Age Bands & Demographics

Identified customer segments driving the highest retail revenue.

Result:
Retirees and Families were the highest revenue-generating segments, contributing ₹6.6B+ in Retail sales.

---
## Key Insights

Analyzed 1B+ transactions from 2018 to 2020, observing consistent year-over-year growth.

Oceania emerged as the highest revenue-generating region across all months.

Retail dominated sales (~97%), while Shopify showed gradual growth from ~2% to ~3.4%.

Families and Couples were the top revenue-generating demographics, with Retirees contributing the highest Retail sales.

---

## Tools Used

MySQL

SQL (CTEs, CASE WHEN, Aggregations, Window Functions)

---
## Future Recommendations

- Expand analysis to full 52-week data to enable accurate seasonality and annual trend forecasting.
- Use demographic and regional insights to design targeted promotions for high-value segments like Families and Retirees.


##  Key Learnings
- Performed real-world data transformation and reporting entirely in SQL
- Gained hands-on experience with `CTEs`, `CASE`, `GROUP BY`, and `PARTITION BY`
- Understood how to draw insights from sales data using pure SQL

---

## 📎 File Included
- `data_mart_case_study.sql`: All SQL queries including data cleaning and exploration
