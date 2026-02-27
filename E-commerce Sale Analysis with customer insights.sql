CREATE DATABASE analysis;
USE analysis;
SELECT * FROM sale;

-- 1️. Total Revenue
SELECT 
    SUM(Revenue) AS Total_Revenue
FROM sale;

-- 2️. Total Orders & Total Customers
SELECT 
    COUNT(DISTINCT InvoiceNo) AS Total_Orders,
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM sale;

-- 3️. Monthly Revenue Trend
SELECT 
    YearMonth,
    SUM(Revenue) AS Monthly_Revenue
FROM sale
GROUP BY YearMonth
ORDER BY YearMonth;

-- 4️. Top 10 Products by Revenue
SELECT 
    Description,
    SUM(Revenue) AS Product_Revenue
FROM sale
GROUP BY Description
ORDER BY Product_Revenue DESC
LIMIT 10;

-- 5️.  Country-wise Revenue
SELECT 
    Country,
    SUM(Revenue) AS Country_Revenue
FROM sale
GROUP BY Country
ORDER BY Country_Revenue DESC;

-- 6️. Top 10 Customers by Revenue
SELECT 
    CustomerID,
    SUM(Revenue) AS Customer_Revenue
FROM sale
GROUP BY CustomerID
ORDER BY Customer_Revenue DESC
LIMIT 10;

-- 7️. Repeat Customers (More than 1 Order)
SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM sale
GROUP BY CustomerID
HAVING COUNT(DISTINCT InvoiceNo) > 1;

-- 8️. Customer Ranking 
SELECT 
    CustomerID,
    SUM(Revenue) AS Customer_Revenue,
    DENSE_RANK() OVER (ORDER BY SUM(Revenue) DESC) AS Customer_Rank
FROM sale
GROUP BY CustomerID;

-- 9️. First Purchase Date 
WITH first_purchase AS (
    SELECT 
        CustomerID,
        MIN(InvoiceDate) AS First_Order_Date
    FROM sale
    GROUP BY CustomerID
)
SELECT * FROM first_purchase;


-- 10.  Daily Revenue with Running Total
SELECT 
    DATE(InvoiceDate) AS Order_Date,
    SUM(Revenue) AS Daily_Revenue,
    SUM(SUM(Revenue)) OVER (ORDER BY DATE(InvoiceDate)) AS Running_Total
FROM sale
GROUP BY DATE(InvoiceDate);

/*
   FINAL INSIGHTS AND RECOMMENDATION 
   INSIGHTS:
   
 1. Revenue shows monthly fluctuations indicating seasonal sales patterns.
 2. A small group of top customers contributes significantly to total revenue.
 3. Top products drive majority of product-level revenue.
 4. Repeat customers play an important role in revenue stability.
 5. Certain countries dominate overall sales contribution.

    RECOMMENDATIONS:
 1. Implement loyalty programs to increase repeat purchase rate.
 2. Focus marketing efforts on high-revenue months.
 3. Promote top-performing products through bundling and cross-selling.
 4. Target high-performing countries with region-specific campaigns.
 5. Introduce strategies to increase Average Order Value (AOV).
 */
 