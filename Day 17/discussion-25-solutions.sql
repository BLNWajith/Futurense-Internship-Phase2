-- Scenario 1: Advanced Analytics Dashboard

-- 1. Inline view to calculate the daily total sales:
CREATE VIEW DailySales AS
SELECT 
    orderDate, 
    SUM(quantityOrdered * priceEach) AS total_sales
FROM 
    orders o
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY 
    orderDate;

-- 2. Updatable view to show the number of orders for each day and update order status:
CREATE VIEW DailyOrderCount AS
SELECT orderDate, COUNT(orderNumber) AS total_orders, MIN(status) AS status
FROM orders
GROUP BY orderDate;

CREATE TRIGGER update_order_status
INSTEAD OF UPDATE ON DailyOrderCount
FOR EACH ROW
BEGIN
    UPDATE orders SET status = NEW.status WHERE orderDate = OLD.orderDate;
END;

-- 3. View to identify the most purchased product of each day:
CREATE VIEW MostPurchasedProduct AS
SELECT orderDate, productCode, SUM(quantityOrdered) AS total_quantity
FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY orderDate, productCode
HAVING SUM(quantityOrdered) = (
    SELECT MAX(sub.total_quantity)
    FROM (
        SELECT orderDate, productCode, SUM(quantityOrdered) AS total_quantity
        FROM orders o2 JOIN orderdetails od2 ON o2.orderNumber = od2.orderNumber
        GROUP BY orderDate, productCode
    ) sub
    WHERE sub.orderDate = orders.orderDate
);

-- 4.  Combined view for the required daily report:
CREATE VIEW DailySalesReport AS
SELECT dt.orderDate, dt.total_sales, dc.total_orders, mp.productCode AS most_purchased_product
FROM DailyTotalSales dt
JOIN DailyOrderCount dc ON dt.orderDate = dc.orderDate
JOIN MostPurchasedProduct mp ON dt.orderDate = mp.orderDate;


-- Scenario 2: Sales Monitoring System

-- 1. View to show the total number of customers handled by each sales rep:
CREATE VIEW CustomersPerSalesRep AS
SELECT e.employeeNumber, COUNT(DISTINCT c.customerNumber) AS total_customers
FROM employees e JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber;

-- 2. View to display the total payments received by each sales rep:
CREATE VIEW PaymentsPerSalesRep AS
SELECT e.employeeNumber, SUM(p.amount) AS total_payments
FROM employees e JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber;

-- 3. View to show the total number of orders handled by each sales rep:View to show the total number of orders handled by each sales rep:
CREATE VIEW OrdersPerSalesRep AS
SELECT e.employeeNumber, COUNT(DISTINCT o.orderNumber) AS total_orders
FROM employees e JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY e.employeeNumber;

-- 4.  Combined view for the required daily report:
CREATE VIEW SalesRepPerformance AS
SELECT cpr.employeeNumber, cpr.total_customers, ppr.total_payments, opr.total_orders
FROM CustomersPerSalesRep cpr
JOIN PaymentsPerSalesRep ppr ON cpr.employeeNumber = ppr.employeeNumber
JOIN OrdersPerSalesRep opr ON cpr.employeeNumber = opr.employeeNumber;


-- 3. Scenario 3: HR and Sales Data Analysis

-- 1. View in the hr database to show the department and age of each employee:
CREATE VIEW EmployeeDeptAge AS
SELECT e.employee_id, d.department_name, YEAR(CURDATE()) - YEAR(e.birth_date) AS age
FROM employees e JOIN departments d ON e.department_id = d.department_id;

-- 2. View in the classicmodels database to show the sales performance of each employee:
CREATE VIEW EmployeeSalesPerformance AS
SELECT e.employeeNumber, COUNT(DISTINCT o.orderNumber) AS total_orders, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM employees e JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY e.employeeNumber;