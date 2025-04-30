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
-Transactions made by each gender and category respectively.
```sql
SELECT
	category,
	gender,
	COUNT(*) AS Transactions
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
ORDER BY Shift;
```

#### Findings and results
---
  - Electronics category was the highest selling category (Kshs. 313,810.00) revenue wise followed by clothing (Kshs. 311,070.00) and beauty (Kshs. 286,840.00). Clothing (701 		 
    items) recorded the most orders followed closely by electronics (684 items) then beauty (612 items).
  - Top sales order was invoice no. 860-79-0874 selling as Kshs. 1,042.65.
  - The profits were predetermined at a margin of 5%.
  - The company experienced boom in sales fo the first quarter then sales dwindeled in the latter quarters.
  - Foods and beverage was the top selling category during the year.
  - Branch sales were evenly distributed during the year.
  - Payment modes of cash, credit card and e-wallet were evenly used across the period.
  - Alexandria branch dominated on food and beverage sales (47%), Giza on home & lifestyle (43%), Cairo on health & beauty (39%).

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
