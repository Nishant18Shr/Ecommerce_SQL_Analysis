CREATE DATABASE Ecommerce;

USE  Ecommerce;

-- Analyze the Data
DESCRIBE customers;
DESCRIBE products;
DESCRIBE orders;
DESCRIBE orderdetails;

-- Question 1
-- Answer 1 = Delhi, Chennai, Jaipur
-- Code below

/* Identify the top 3 cities with the highest number of customers to determine key markets for targeted marketing and logistic optimization. */
SELECT 
    location,
    COUNT(customer_id) AS number_of_customers
FROM customers
GROUP BY location
ORDER BY COUNT(customer_id) DESC
LIMIT 3;


-- Question - 2 As per the Engagement Depth Analysis question, What is the trend of the number of customers v/s number of orders?
-- Answer 2 = As the number of orders increases, the customer count decrease.

-- Question 3 As per the Engagement Depth Analysis question, Which customers category does the company experiences the most?
-- Answer 3 = Occasional Shoppers
-- Code below

/* Determine how many customers fall into each order frequency category based on the number of orders they have placed. */
WITH cte_NumberOfOrders AS (
    SELECT
        customer_id,
        COUNT(order_id) AS NumberOfOrders 
    FROM Orders 
    GROUP BY customer_id
)
SELECT 
    NumberOfOrders,
    COUNT(customer_id) AS CustomerCount
FROM cte_NumberOfOrders
GROUP BY NumberOfOrders
ORDER BY NumberOfOrders;

-- Question 4 Among products with an average purchase quantity of two, which ones exhibit the highest total revenue?
-- Answer 4 = Product Id 1
-- Code below 

/* Identify products where the average purchase quantity per order is 2 but with a high total revenue, suggesting premium product trends. */
SELECT
	product_id AS Product_Id,
	AVG(quantity) AS AvgQuantity,
	SUM(quantity*price_per_unit) AS TotalRevenue
FROM OrderDetails
GROUP BY product_id
HAVING AvgQuantity = 2
ORDER BY TotalRevenue DESC;

-- Question 5 As per the last question, Which product category needs more focus as it is in high demand among the customers?
-- Answer 5 = Electronics
-- Code below

/* For each product category, calculate the unique number of customers purchasing from it.
 This will help understand which categories have wider appeal across the customer base. */
SELECT 
	category,
	COUNT(DISTINCT customer_id) AS unique_Customers
FROM Products p 
JOIN OrderDetails od 
	ON p.product_id = od.product_id
JOIN Orders o 
	ON o.order_id = od.order_id
GROUP BY category
ORDER BY unique_Customers DESC;


-- Question 6 As per Sales Trend Analysis question, During which month did the sales experience the largest decline?
-- Answer = FEB 2024

-- Question 7 As per Sales Trend Analysis question, What could be inferred about the sales trend from March to August?
-- Answer 7 Sales flactuated with no clear trend
-- Code Below

-- Analyze the month-on-month percentage change in total sales to identify growth trends.
WITH CTE_TotalSales AS (
    SELECT 
        DATE_FORMAT(order_date,'%Y-%m') AS Month,
        ROUND(SUM(total_amount),2) AS TotalSales
    FROM Orders
    GROUP BY Month
),
CTE_OldMonthSales AS (
SELECT
    Month,
    TotalSales,
    LAG(TotalSales) OVER (ORDER BY Month) AS PreviuosMonthSales
FROM CTE_TotalSales
)
SELECT 
Month,
TotalSales,
ROUND(((TotalSales-PreviuosMonthSales)/PreviuosMonthSales*100),2) AS PercentChange
FROM CTE_OldMonthSales;

-- Question 8 As per last question, Which month has the highest change in the average order value?
-- Answer 8 = December
-- Code below

/* Examine how the average order value changes month-on-month. Insights can guide pricing and promotional strategies to enhance order value. */
WITH CTE_TotalSales AS (
    SELECT 
        DATE_FORMAT(order_date,'%Y-%m') AS Month,
        ROUND(AVG(total_amount),2) AS AvgOrderValue
    FROM Orders
    GROUP BY Month
),
CTE_OldMonthSales AS (
SELECT
    Month,
    AvgOrderValue,
    LAG(AvgOrderValue) OVER (ORDER BY Month) AS PreviuosMonthAvg
FROM CTE_TotalSales
)
SELECT 
Month,
AvgOrderValue,
ROUND((AvgOrderValue-PreviuosMonthAvg),2) AS ChangeInValue
FROM CTE_OldMonthSales
ORDER BY ChangeInValue DESC;

-- Question 9 As per last question, Which product_id has the highest turnover rates and needs to be restocked frequently?
-- Answer 9 = 7
-- Code Below

/* Based on sales data, identify products with the fastest turnover rates, suggesting high demand and the need for frequent restocking. */
SELECT
    product_id,
    COUNT(
        CASE 
            WHEN quantity >= 1 THEN 1
        END) AS SalesFrequency
FROM OrderDetails
GROUP BY product_id
ORDER BY SalesFrequency DESC
LIMIT 5;


-- Question 10 Why might certain products have purchase rates below 40% of the total customer base?
-- Answer 10 = Poor visibility on the platform

-- Question 11 After running an analysis to identify products purchased by less than 40% of the customer base, it was found that a few products have lower purchase rates than expected.
-- Answer 11 Implement targeted marketing campaigns to raise awareness and interest.
-- Code Below

/* List products purchased by less than 40% of the customer base, indicating potential mismatches between inventory and customer interest. */
SELECT 
    p.product_id, 
    p.name,
    COUNT(DISTINCT o.customer_id) AS UniqueCustomerCount
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
GROUP BY p.product_id, p.name
HAVING COUNT(DISTINCT o.customer_id) < (
    SELECT COUNT(DISTINCT customer_id) * 0.4 
    FROM Customers
)
ORDER BY UniqueCustomerCount ASC;


-- Question 12 As per last question, What can be inferred about the growth trend in the customer base from the result table?
-- Answer 12 = it is the downward trend which shows poor marketing.
-- Code Below
/* Evaluate the month-on-month growth rate in the customer base to understand the effectiveness of marketing campaigns and market expansion efforts. */
SELECT 
    DATE_FORMAT(FirstPurchaseDate, '%Y-%m') AS FirstPurchaseMonth,
    COUNT(customer_id) AS TotalNewCustomers
FROM (
    -- Subquery to find the absolute first purchase for every customer
    SELECT 
        customer_id, 
        MIN(order_date) AS FirstPurchaseDate
    FROM Orders
    GROUP BY customer_id
) AS CustomerFirstOrders
GROUP BY FirstPurchaseMonth
ORDER BY FirstPurchaseMonth;


-- Question 13 As per last question, Which months will require major restocking of product and increased staffs?
-- Answer 13 = September , December
-- Code Below

/* Identify the months with the highest sales volume, aiding in planning for stock levels, marketing efforts, and staffing in anticipation of peak demand periods. */
SELECT 
    DATE_FORMAT(order_date,'%Y-%m') AS Month,
    SUM(total_amount) AS TotalSales
FROM Orders
GROUP BY Month
ORDER BY TotalSales DESC
LIMIT 3;
