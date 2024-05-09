-- 1
SELECT c1.city, c1.customerName, c2.customerName FROM customers c1 JOIN customers c2 ON c1.city = c2.city WHERE c1.customerName != c2.customerName order by a.city;

-- 2
SELECT p.productCode, p.productName, pl.textDescription FROM products p INNER JOIN productlines pl ON p.productline = pl.productline;

-- 3
select a.orderNumber,status,SUM(quantityOrdered * priceEach) as total from orders a inner join orderdetails b on a.orderNumber=b.orderNumber group by a.orderNumber;

-- 4 
select orderNumber,orderDate,orderLineNumber,productName,quantityOrdered,priceEach from orders inner join orderdetails using (orderNumber) inner join products using (productCode) order by orderNumber,orderLineNumber;

-- 5
select orderNumber,orderDate,customerName,orderLineNumber,productName,quantityOrdered,priceEach from orders inner join orderdetails using (orderNumber) inner join products using (productCode) inner join customers using(customerNumber) order by orderNumber,orderLineNumber;

-- 6
select orderNumber,productName,msrp,priceEach from products a inner join orderdetails b on a.productcode=b.productcode and a.msrp>b.priceEach where a.productCode='S10_1678';

-- 7
select a.customerNumber,a.customerName,b.orderNumber,b.status from customers a inner join orders b on a.customerNumber=b.customerNumber order by a.customerNumber;

-- 8
select a.customerNumber,a.customerName,b.orderNumber,b.status from customers a left join orders b on a.customernumber=b.customernumber and b.ordernumber is null;