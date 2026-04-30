1: TOTAL ORDERS & BASIC KPIs
-----------------------------------
SELECT 
    COUNT(*) AS total_orders,
    ROUND(AVG(time_taken),2) AS avg_delivery_time,
    ROUND(AVG(subtotal),2) AS avg_order_value
FROM Porter_data;

2: DELIVERY TIME DISTRIBUTION
-----------------------------------
SELECT 
    CASE 
        WHEN time_taken < 30 THEN 'Fast (<30)'
        WHEN time_taken BETWEEN 30 AND 60 THEN 'Normal (30-60)'
        ELSE 'Delayed (>60)'
    END AS delivery_bucket,
    COUNT(*) AS total_orders
FROM porter_data
GROUP BY delivery_bucket;

3. ORDER BY HOURS
-------------------

SELECT
 HOUR(order_time + INTERVAL 5 HOUR + INTERVAL 30 MINUTE) AS order_by_hours,
 COUNT(*) AS total_orders,
 ROUND(AVG(time_taken),2) AS avg_time_taken
 FROM porter_data
 GROUP BY order_by_hours
 ORDER BY order_by_hours;
 
4. DAY-WISE PERFORMANCE
---------------------------
SELECT 
DAY(order_time) AS Day,
COUNT(*) AS Total_orders,
 ROUND(AVG(time_taken),2) AS avg_time_taken
 FROM porter_data
 GROUP BY Day
 ORDER BY Total_orders DESC;
 
 5. CATEGORY WISE DELIVERY PERFORMANCE
 -------------------------------------
 SELECT 
 store_primary_category,
 COUNT(*) AS total_orders,
 ROUND(AVG(time_taken),2) AS avg_time_taken
 FROM porter_data
 GROUP BY store_primary_category
 ORDER BY avg_time_taken;
 
 6. DEMAND vs SUPPLY IMPACT
 -----------------------------
SELECT 
ROUND(busy_partners / onshift_partners,2) AS demand_supply_ratio,
COUNT(*) AS total_orders,
ROUND(AVG(time_taken),2) AS total_time_taken
FROM porter_data
WHERE onshift_partners > 0
GROUP BY ROUND(busy_partners / onshift_partners,2)
ORDER BY demand_supply_ratio DESC;

7. ORDER VALUE ANALYSIS
-----------------------

SELECT
MIN(subtotal) AS min_order,
MAX(subtotal) AS max_order,
ROUND(AVG(subtotal),2) AS avg_order_value
FROM porter_data

8. ORDER VALUE vs DELIVERY TIME
--------------------------------

SELECT
CASE
WHEN subtotal < 200 THEN 'LOW VALUE'
WHEN subtotal BETWEEN 200 AND 500 THEN 'MEDIUM VALUE'
ELSE 'HIGH VALUE'
END AS order_type,
COUNT(*) AS total_order,
ROUND(AVG(time_taken),2) AS avg_time_taken
FROM porter_data
GROUP BY order_type;

9.IMPACT OF ORDER SIZE
--------------------------

SELECT
total_items,
COUNT(*) AS total_order,
ROUND(AVG(time_taken),2) AS avg_time_taken
FROM porter_data
GROUP BY total_items
ORDER BY total_items;

10. HIGH DELAY ORDERS
---------------------

SELECT *
FROM porter_data
ORDER BY time_taken DESC
LIMIT 10;



