-- 1
-- Write a query to find customers whose payments are greater than the average payment using a subquery.
SELECT customerNumber, customerName, amount FROM payments WHERE amount > (SELECT AVG(amount) FROM payments);

-- 2
-- See the following customers and orders tables: Use a subquery with NOT IN operator to find the customers who have not placed any orders.
SELECT customerNumber, customerName FROM customers WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);

-- 3
-- Write a subquery that finds the maximum, minimum, and average number of items in sale orders from orderdetails.
SELECT MAX(quantityOrdered) AS max_items, MIN(quantityOrdered) AS min_items, AVG(quantityOrdered) AS avg_itemsFROM orderdetails;

-- 4
-- 
SELECT productCode, productName, productLine, buyPrice FROM products p1 WHERE buyPrice > (SELECT AVG(buyPrice) FROM products p2 WHERE p2.productLine = p1.productLine);

-- 5
-- Let’s take a look at the orders and orderdetails tables: Write a query that finds sales orders whose total values are greater than 60K as follows:
SELECT o.orderNumber, SUM(od.quantityOrdered * od.priceEach) AS total_value FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber GROUP BY o.orderNumber HAVING total_value > 60000;

-- 6
-- When a subquery is used with the EXISTS or NOT EXISTS operator, a subquery returns a Boolean value of TRUE or FALSE. The following query illustrates a subquery used with the EXISTS operator:
SELECT c.customerNumber, c.customerName FROM customers c WHERE EXISTS (SELECT 1
            FROM orders o
            JOIN orderdetails od ON o.orderNumber = od.orderNumber
            WHERE o.customerNumber = c.customerNumber
            GROUP BY o.orderNumber
            HAVING SUM(od.quantityOrdered * od.priceEach) > 60000);

-- 7
-- Let's take a look at the orders and orderdetails table: Write a query that gets the top five products by sales revenue in 2003 from the orders and orderdetails tables as follows:
SELECT od.productCode, SUM(od.quantityOrdered * od.priceEach) AS total_revenue FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber WHERE YEAR(o.orderDate) = 2003 GROUP BY od.productCode ORDER BY total_revenue DESC LIMIT 5;

-- 8
-- You can use the result of the previous query as a derived table called top5product2003 and join it with the products table using the productCode column.. Then, find out the productName and sales of the top 5 products in 2003.
SELECT p.productName, top5.total_revenue FROM (SELECT od.productCode, SUM(od.quantityOrdered * od.priceEach)  AS total_revenue FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber WHERE YEAR(o.orderDate) = 2003 GROUP BY od.productCode ORDER BY total_revenue DESC LIMIT 5) AS top5 JOIN products p ON top5.productCode = p.productCode;

-- 9
-- Suppose you have to label the customers who bought products in 2003 into 3 groups: platinum, gold, and silver with the following conditions:
-- Platinum customers who have orders with the volume greater than 100K.
-- Gold customers who have orders with the volume between 10K and 100K.
-- Silver customers who have orders with the volume less than 10K.
-- To form this query, you first need to put each customer into the respective group using CASE expression and GROUP BY to display the following:
SELECT 
    c.customerNumber, c.customerName,
    CASE
        WHEN SUM(od.quantityOrdered * od.priceEach) > 100000 THEN 'Platinum'
        WHEN SUM(od.quantityOrdered * od.priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
        ELSE 'Silver'
    END AS customer_group
FROM customers c JOIN orders o ON c.customerNumber = o.customerNumber JOIN orderdetails od ON o.orderNumber = od.orderNumber WHERE YEAR(o.orderDate) = 2003 GROUP BY c.customerNumber, c.customerName;

-- 10
-- Use the previous query as the derived table to know the number of customers in each group: platinum, gold, and silver.
SELECT 
    customer_group, COUNT(*) AS number_of_customers
FROM 
    (SELECT 
         c.customerNumber, c.customerName,
         CASE
             WHEN SUM(od.quantityOrdered * od.priceEach) > 100000 THEN 'Platinum'
             WHEN SUM(od.quantityOrdered * od.priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
             ELSE 'Silver'
         END AS customer_group
     FROM 
         customers c
     JOIN 
         orders o ON c.customerNumber = o.customerNumber
     JOIN 
         orderdetails od ON o.orderNumber = od.orderNumber
     WHERE 
         YEAR(o.orderDate) = 2003
     GROUP BY 
         c.customerNumber, c.customerName) AS grouped_customers GROUP BY customerGroup;