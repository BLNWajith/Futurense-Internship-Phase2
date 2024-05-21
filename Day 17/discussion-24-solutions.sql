-- 1
-- Updatable View:
-- Create an updatable view that includes customerNumber, customerName, contactLastName, and contactFirstName from the customers table. Then, try to update the contactFirstName for a specific customerNumber.
UPDATE customer_view SET contactFirstName = 'NewFirstName' WHERE customerNumber = some_number;

-- 2
-- Read-Only View:
-- Create a read-only view that joins the orderdetails table and the products table on productCode and includes orderNumber, productName, and quantityOrdered. Try to update the quantityOrdered for a specific orderNumber and see what happens.
CREATE VIEW order_product_view AS SELECT od.orderNumber, p.productName, od.quantityOrdered FROM orderdetails od JOIN products p ON od.productCode = p.productCode;
-- (got an error because it involves multiple base tables.)

-- 3
--Inline View:
-- Write a query that uses an inline view to get the total number of orders for each customer. The inline view should select customerNumber and orderNumber from the orders table. The main query should then group by customerNumber.Inline View:
select customerNumber,count(orderNumber) from (select customerNumber,orderNumber from orders) as inline_view group by customerNumber;
-- 4
-- Materialized View:
-- Note that MySQL does not natively support materialized views, but you can mimic them with a combination of stored procedures and triggers. The task here would be to create a stored procedure that creates a new table with productName and totalQuantityOrdered 
-- (this total should be aggregated from the orderdetails table). Then, create an AFTER INSERT trigger on the orderdetails table that calls this stored procedure to update the table (acting as a materialized view) whenever a new order detail is inserted.
create procedure refresh_materialized_view()
    begin
    create table materialized_view as select p.productName,sum(od.quantityOrdered) as total_quantity_ordered from orderdetails od join products p on od.productCode = p.productCode group by p.productName;
    end &
    delimiter ;
create trigger orderdetails_after_insert after insert on orderdetails for each row call refresh_materialized_view();
