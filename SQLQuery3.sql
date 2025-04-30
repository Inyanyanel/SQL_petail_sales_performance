USE Herewegosqlprojectdb;

--Data Cleaning--
USE Herewegosqlprojectdb;
SELECT * FROM Retail_performance;

SELECT * FROM Retail_performance
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity  IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

UPDATE Retail_performance
SET age=(SELECT AVG(AGE) FROM Retail_performance WHERE age IS NOT NULL)
WHERE age IS NULL;

DELETE FROM Retail_performance
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity  IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

SELECT COUNT(*) FROM Retail_performance;

--Data Exploration--

---Sales activity/Number of transactions--

SELECT COUNT(*) AS Number_of_transactions FROM Retail_performance;

--Number of Customers--

SELECT COUNT(DISTINCT(customer_id))AS Number_of_Customers from Retail_performance;

--Products Categories--

SELECT DISTINCT category FROM Retail_performance;

SELECT COUNT(DISTINCT(category)) AS No_of_Categories FROM Retail_performance;

--Data Analysis & Key Business Metrics--

--1. All sales made on 2022-11-05

SELECT * FROM Retail_performance
WHERE sale_date='2022-11-05';

--2.Clothing Transactions with 2 or more items sold on November 2022--

SELECT *
FROM Retail_performance
WHERE category='Clothing'
AND FORMAT(Sale_date, 'yyyy-MM')='2022-11'
AND quantity>=4;

--3.Sales Amount Categorywise--

SELECT  
	category,
	SUM(total_sale) AS Revenue_per_category,
	COUNT(*) AS No_Of_Orders
FROM Retail_performance
GROUP BY category
ORDER BY 3;


--3.Average Customer Age By Category--

SELECT
	category,
	AVG(age) AS Average_age
FROM Retail_performance
WHERE category='Beauty'
GROUP BY category;

--5.Transactions with sales worth over 1000--

SELECT * 
FROM Retail_performance
WHERE total_sale>1000;

--6.Transactions made by each gender and category respectivly--
SELECT
	category,
	gender,
	COUNT(*) AS Transactions
FROM Retail_performance
GROUP BY category,gender;

--7.Best selling months by monthly average each year--

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

--8.Top 5 business customerwise--

SELECT TOP 5
	customer_id,
	SUM(total_sale) AS Total_Business
FROM Retail_performance
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC;

--9.Number of customers who purchsed from each category--

SELECT
	category,
	COUNT(DISTINCT(customer_id)) AS Customers,
	SUM(quantity) Item_sold
FROM Retail_performance
GROUP BY category;

--10.Orders per shift(Morning <1200hrs, Afternoon >=1200hrs & <=1700hrs, Evening >1700hrs--

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
	COUNT(*) AS No_of_orders
FROM Shift_orders
GROUP BY Shift, gender
ORDER BY Shift;


