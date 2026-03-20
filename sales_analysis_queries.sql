-- ============================================
-- CUSTOMER SEGMENTATION & REVENUE ANALYSIS
-- ============================================


-- 1. View all customers
SELECT * 
FROM customers;


-- 2. Customers from Bangalore
SELECT name, city 
FROM customers 
WHERE city = 'Bangalore';


-- 3. Count of customers from Bangalore
SELECT COUNT(*) AS total_customers
FROM customers 
WHERE city = 'Bangalore';


-- 4. Customer orders with order details
SELECT 
    c.name,
    o.order_id,
    o.order_date 
FROM customers c  
JOIN orders o 
    ON c.customer_id = o.customer_id;


-- 5. Total number of orders per customer
SELECT 
    c.customer_id, 
    c.name,
    COUNT(o.order_id) AS total_orders
FROM customers c 
JOIN orders o 
    ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.name;


-- 6. Top 5 customers by number of orders
SELECT  
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders 
FROM customers c 
JOIN orders o 
    ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC 
LIMIT 5;


-- 7. Top 5 customers by revenue
SELECT 
    c.customer_id,
    c.name, 
    SUM(ot.quantity * ot.price) AS total_revenue
FROM customers c 
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items ot 
    ON ot.order_id = o.order_id
GROUP BY c.customer_id, c.name
ORDER BY total_revenue DESC 
LIMIT 5;


-- 8. Monthly revenue trend
SELECT 
    strftime('%Y-%m', o.order_date) AS month,
    SUM(ot.quantity * ot.price) AS total_revenue
FROM orders o
JOIN order_items ot 
    ON ot.order_id = o.order_id
GROUP BY month
ORDER BY total_revenue DESC;


-- 9. Customers who ordered only once
SELECT 
    c.customer_id,
    c.name, 
    COUNT(o.order_id) AS total_orders
FROM customers c 
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) = 1;


-- 10. Customers who ordered more than once
SELECT 
    c.customer_id,
    c.name, 
    COUNT(o.order_id) AS total_orders
FROM customers c 
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 1;


-- 11. Top 3 products by revenue
SELECT 
    p.product_id,
    p.product_name,
    SUM(ot.quantity * ot.price) AS total_product_revenue
FROM products p
JOIN order_items ot
    ON p.product_id = ot.product_id
JOIN orders o 
    ON ot.order_id = o.order_id
GROUP BY p.product_id, p.product_name
ORDER BY total_product_revenue DESC 
LIMIT 3;


-- 12. Customers with above-average revenue
SELECT 
    c.customer_id,
    c.name,
    SUM(ot.quantity * ot.price) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items ot 
    ON o.order_id = ot.order_id
GROUP BY c.customer_id, c.name
HAVING total_revenue > (
    SELECT AVG(customer_revenue)
    FROM (
        SELECT 
            c.customer_id,
            SUM(ot.quantity * ot.price) AS customer_revenue
        FROM customers c
        JOIN orders o 
            ON c.customer_id = o.customer_id
        JOIN order_items ot 
            ON o.order_id = ot.order_id
        GROUP BY c.customer_id
    )
);


-- 13. Customer segmentation based on revenue
SELECT 
    c.customer_id,
    c.name,
    SUM(ot.quantity * ot.price) AS total_revenue,
    
    CASE
        WHEN SUM(ot.quantity * ot.price) > 50000 THEN 'High Value'
        WHEN SUM(ot.quantity * ot.price) BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment 

FROM customers c 
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items ot 
    ON ot.order_id = o.order_id
GROUP BY c.customer_id, c.name
ORDER BY total_revenue DESC;


-- 14. Revenue contribution by customer segment
SELECT 
    customer_segment,
    SUM(total_revenue) AS segment_revenue
FROM (
    SELECT 
        c.customer_id,
        SUM(ot.quantity * ot.price) AS total_revenue,
        
        CASE
            WHEN SUM(ot.quantity * ot.price) > 50000 THEN 'High Value'
            WHEN SUM(ot.quantity * ot.price) BETWEEN 20000 AND 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment 
        
    FROM customers c 
    JOIN orders o 
        ON c.customer_id = o.customer_id
    JOIN order_items ot 
        ON ot.order_id = o.order_id
    GROUP BY c.customer_id
) AS temp
GROUP BY customer_segment
ORDER BY segment_revenue DESC;