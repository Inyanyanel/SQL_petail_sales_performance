# SQL_Retail_Sales_Performance
## Table Of Contents
---

- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools used](#tools-used)
- [Data preparation](#data-preparation)
- [Data Analysis]($data-analysis)
- [Findings and results]($findings-and-results)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [References](#references)

### Project Overview
---

This project aims to provide quickfire business metrics seeking to identify the trends and gain a geveral overview of the sales performance to make necessary recommendations.

### Data Sources
---

Retail sales Data: The primary dataset used for this analysis is the "Rtail_sales.csv" file from Zero anayst github platform. [Check Here](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa2ZGcV9ZLVJlNUJnTkpKX1NyY0xwYWZIQ3pPUXxBQ3Jtc0tsblFDeHotdTIzbEJJNkMwLV81bWpmV0hTOW9TVUZKVnZvdDhhYkFWd2RsV3g5Mm02VC1oQ1VwamZrbDNVc0E3aHYtOXBJYWwyaVJFUEwzdEVUc21rNUwzTTM1Q2NWcDg5OENtcHN5ZWpJOXZKRkU5aw&q=https%3A%2F%2Fgithub.com%2Fnajirh%2FRetail-Sales-Analysis-SQL-Project--P1%2Fblob%2Fmain%2FSQL%2520-%2520Retail%2520Sales%2520Analysis_utf%2520.csv&v=ChIQjGBI3AM).

### Tools used
---

- SQL - Used to clean, transform and analyse data.

### Data preparation
---

- Data loading and inspection.
- Handling missing values.
- Data cleaning, formatting and transformation.

### Data Analysis
---
We predominantly used SQL querrying as demonstrated below;
#### Formulas
  - Sales Amount Categorywise.
```sql
SELECT  
	category,
	SUM(total_sale) AS Revenue_per_category,
	COUNT(*) AS No_Of_Orders
FROM Retail_performance
GROUP BY category
ORDER BY 3;

```
-Average Customer Age For Beauty Category.
```sql
SELECT
	category,
	AVG(age) AS Average_age
FROM Retail_performance
WHERE category='Beauty'
GROUP BY category;
```
-Transactions with sales worth over 1000.
```sql
SELECT * 
FROM Retail_performance
WHERE total_sale>1000;
```
-Revenue and orders made per gender and category respectively.
```sql
SELECT
	category,
	gender,
	COUNT(*) AS Transactions,
	SUM(Total_sale) AS Total_sales
FROM Retail_performance
GROUP BY category,gender;
```
-Best selling months by monthly average each year.
```sql
SELECT Year,
	Month,
	Monthly_Average_Sales
FROM (
	SELECT
		FORMAT(sale_date,'yyyy') AS Year,
		FORMAT(sale_date,'MM') AS Month,
		ROUND(AVG(total_sale),2) AS Monthly_Average_Sales,
		RANK() OVER(PARTITION BY FORMAT(sale_date,'yyyy') ORDER BY ROUND(AVG(total_sale),2) DESC) AS _Rank
	FROM Retail_performance
	GROUP BY FORMAT(sale_date,'yyyy'), FORMAT(sale_date,'MM')
	) Best_monthly_performance
	WHERE _Rank=1;
```
-Five premium customers.
```sql
SELECT TOP 5
	customer_id,
	SUM(total_sale) AS Total_Business
FROM Retail_performance
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC;
```
-Product categories performance.
```sql
SELECT
	category,
	COUNT(DISTINCT(customer_id)) AS Customers,
	SUM(quantity) Item_sold
FROM Retail_performance
GROUP BY category;
```
-Shifts performance.
```sql
WITH Shift_orders
AS
	(
	SELECT *,
		CASE WHEN DATEPART(HOUR, sale_time)<12 THEN 'Morning'
			 WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 16 THEN 'Afternoon'
			 ELSE 'Evening'
		END AS Shift
	FROM Retail_performance
	)
SELECT
	Shift,
	gender,
	COUNT(*) AS No_of_orders,
	SUM(total_sale) as Shift_sales
FROM Shift_orders
GROUP BY Shift, gender
ORDER BY 4 DESC;
```

#### Findings and results
---
  - Electronics category was the highest selling category (313,810.00) revenue wise followed by clothing (311,070.00) and beauty (286,840.00). Clothing (701 		 
    items) recorded the most orders followed closely by electronics (684 items) then beauty (612 items).
  - Beauty products were mostly consumed by middle aged people (Average age 40 years)
  - Just over 15% of total orders recorded sale amounts of Kshs. 1,000.00 and above.
  - Ladies led the spending on clothing products (162,460.00) closely followed by men on Electronics (160,340.00). Ladies dominated men on expenditure on the rest of the products.
  - July was the best selling month in year 2022 with monthly average revenue of 541.34 while February topped year 2023 with 535.53
  - Client with customer_id 3 topped the list of premium clients with purchases amounting to 38,440.00 Followed by 1,5,2 and 4 with 30,750.00, 30,405.00, 25,295.00 and 23,580.00 
    respectively.
  - Clothing products topped the category performance with 1,785 orders and 149 customers followed by Electronics with 1,698 orders and 144 customers then Beauty with 1,535 orders and 
    141 customers.
  - Evening shifts recorded the highest sales 572,420.00 and customer traffic 1,275 followed by mornings with 259,900.00 and 558 visits. Afternoons recorded lowest sales of 79,400.00 
    and client traffic of 164. Ladies dominated in the afternoons and evenings both on purchases and traffic while morning saw both genders share the spoils traffic wise with men 
    slightly edging the ladies on purchases.

#### Recommendations
---
Based on the highlighted observations, we recommend the following courses of actions.
  - Invest in marketing promotions to boost sales in the latter three quarters.
  - Incentives should be offered on food and beverage category to boost sales.
  - Each branch need to adopt its top selling category into a respective flagship outlet to bost sales.
  - Profit margin need to be slightly slashed to 4% to reduce the price in order to try boost sales in the last three quarters.

#### Limitations
---
  - Three rows had several null values therefore deleted.
  - Ten rows had null age value therefore filled with average age of the entire dataset.
