/*
PIZZA SALES SQL QUERIES
This script contains a series of SQL queries to analyze pizza sales data.
The queries cover Key Performance Indicators (KPIs), sales trends, and performance by pizza category, size, and name.
*/

-- ===================================================================================
-- A. KEY PERFORMANCE INDICATORS (KPI’s)
-- ===================================================================================

-- 1. Total Revenue: The sum of the total price of all pizza orders.
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- 2. Average Order Value: The average amount spent per order.
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales;

-- 3. Total Pizzas Sold: The sum of the quantities of all pizzas sold.
SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales;

-- 4. Total Orders: The total number of distinct orders placed.
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;

-- 5. Average Pizzas Per Order: The average number of pizzas sold per order.
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM pizza_sales;


-- ===================================================================================
-- B. DAILY AND MONTHLY TRENDS
-- ===================================================================================

-- 1. Daily Trend for Total Orders: Total orders for each day of the week.
SELECT 
    DATENAME(DW, order_date) AS order_day, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

-- 2. Monthly Trend for Total Orders: Total orders for each month.
SELECT 
    DATENAME(MONTH, order_date) AS Month_Name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date);


-- ===================================================================================
-- C. SALES ANALYSIS BY CATEGORY AND SIZE
-- ===================================================================================

-- 1. Percentage of Sales by Pizza Category
SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- 2. Percentage of Sales by Pizza Size
SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- 3. Total Pizzas Sold by Pizza Category (for a specific month, e.g., February)
SELECT 
    pizza_category, 
    SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2 -- Filters for February
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- ===================================================================================
-- D. TOP AND BOTTOM PIZZA PERFORMANCE
-- ===================================================================================

-- 1. Top 5 Pizzas by Revenue
SELECT 
    TOP 5 pizza_name, 
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- 2. Bottom 5 Pizzas by Revenue
SELECT 
    TOP 5 pizza_name, 
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- 3. Top 5 Pizzas by Quantity Sold
SELECT 
    TOP 5 pizza_name, 
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

-- 4. Bottom 5 Pizzas by Quantity Sold
SELECT 
    TOP 5 pizza_name, 
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;

-- 5. Top 5 Pizzas by Total Orders
SELECT 
    TOP 5 pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- 6. Bottom 5 Pizzas by Total Orders
SELECT 
    TOP 5 pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;


-- ===================================================================================
-- NOTE: EXAMPLE OF USING WHERE CLAUSE FOR FILTERING
-- ===================================================================================

-- This example shows how to find the bottom 5 classic pizzas by the number of orders.
-- The WHERE clause can be used to filter by pizza_category, pizza_size, etc.
SELECT 
    TOP 5 pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic' -- Applying a filter for the 'Classic' category
GROUP BY pizza_name
ORDER BY Total_Orders ASC;
