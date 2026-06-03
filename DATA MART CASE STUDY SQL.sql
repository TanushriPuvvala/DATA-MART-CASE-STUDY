use case1;
select * from weekly_sales limit 10;
## DATA CLEANSING 

CREATE TABLE CLEAN_WEEKLY_SALES as
select week_date,
week(week_date) as week_number,
month(week_date) as month_number,
year(week_date) as calendar_year,
region,platform,
case 
    when right(segment,1)='1' then 'Young_Adults'
    when right(segment,1)='2' then 'Middle_Aged'
    when right(segment,1) in ('3','4') then 'Retirees'
    else 'Unknown'
    end as Age_Band,
    
case
    when left(segment,1) = 'C' then 'Couples'
    when left(segment,1) = 'F' then 'Families'
    else 'Unknown'
    end as Demographic,
    customer_type,transactions,sales,
    round(sales/transactions,2) as Avg_Transaction 
FROM WEEKLY_SALES;

select * from clean_weekly_sales limit 10;


## DATA EXPLORATION

## 1.Which week numbers are missing from the dataset?
create table seq100
(x int not null auto_increment primary key);
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 select x + 50 from seq100;
select * from seq100;

create table seq52 as (select x from seq100 limit 52);
select distinct x as week_day from seq52 where x not in(select distinct week_number from clean_weekly_sales); 

select distinct week_number from clean_weekly_sales;

## 2.How many total transactions were there for each year in the dataset?

select 
calendar_year,
sum(transactions) as total_transactions
from  clean_weekly_sales 
group by calendar_year;

## 3.What are the total sales for each region for each month?

select month_number,region,
sum(sales) as Total_sales
from clean_weekly_sales 
group by month_number,region
order by month_number,region;

## 4.What is the total count of transactions for each platform

select platform,sum(transactions) as Total_transactions
from clean_weekly_sales 
group by platform; 

## 5.What is the percentage of sales for Retail vs Shopify for each month?
select * from clean_weekly_sales;
WITH cte_monthly_platform_sales AS (
  SELECT
    month_number,calendar_year,
    platform,
    SUM(sales) AS monthly_sales
  FROM clean_weekly_sales
  GROUP BY month_number,calendar_year, platform
)
SELECT
  month_number,calendar_year,
  ROUND(
    100 * MAX(CASE WHEN platform = 'Retail' THEN monthly_sales ELSE NULL END) /
      SUM(monthly_sales),
    2
  ) AS retail_percentage,
  ROUND(
    100 * MAX(CASE WHEN platform = 'Shopify' THEN monthly_sales ELSE NULL END) /
      SUM(monthly_sales),
    2
  ) AS shopify_percentage
FROM cte_monthly_platform_sales
GROUP BY month_number,calendar_year
ORDER BY month_number,calendar_year;

## 6.What is the percentage of sales by demographic for each year in the dataset?

select calendar_year,demographic,
sum(sales)as Yearly_sales,
round((100*sum(sales)/sum(sum(sales)) over (partition by demographic)),2)as percentage
FROM clean_weekly_sales
GROUP BY calendar_year,demographic
ORDER BY calendar_year,demographic;

## 7.Which age_band and demographic values contribute the most to Retail sales?

select age_band,demographic,sum(sales) as Total_sales from clean_weekly_sales
where platform='retail'
group by age_band,demographic
order by total_sales desc;

---------------thank you-----------------
