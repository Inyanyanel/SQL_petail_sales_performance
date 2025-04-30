# SQL_petail_sales_performance
## Table Of Contents
---

- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools used](#tools-used)
- [Data preparation](#data-preparation)
- [Explanatory analysis](#explanatory-analysis)
- [Data Analysis]($data-analysis)
- [Functions](#functions)
- [Findings and results]($findings-and-results)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [References](#references)

### Project Overview
---

This data analysis project aims to provide insights into the sales performance of a supermarket in year 2019. We are  looking into various sales aspects seeking to identify the trends, gain a deeper understanding of the sales performance and make recommendations.

### Data Sources
---

Sales Data: The primary dataset used for this analysis is the "supermarket_sales.csv" file from kaggle.com datasets [Check Here](https://www.kaggle.com/datasets/alexhuitron/supermarket-sales).

### Tools used
---

- Excel - Used to clean, transform, analyse and visualisation.

### Data preparation
---

- Data loading and inspection.
- Handling missing values.
- Data cleaning, formatting and transformation.

### Explanatory analysis
---
- What was the total sales and profits trend?
-  What were the top selling categories and invoices?
-  What were most preferred payments over the year?
-  What were the top branches and why?

### Data Analysis
---
We predominantly used excel functions and formulas as demonstrated below;
#### Formulas
  - Sum-used to get total sales, cost of goods sold and profits.
  - Count-used to get total number of transactions.
##### Functions
---
  - Sumifs-used to get total sales and profits per category and salesper branch.
  - Countifs-used to get total transactions and payment modes per category.
  - Xlookup-used to get sales and units quantity per invoice during the year.

#### Findings and results
---
  - January was the top selling month with Kshs. 75,160.51 while April the lowest at Kshs. 2,870.46.
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
