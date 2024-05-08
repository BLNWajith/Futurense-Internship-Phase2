-- 1.1
-- Total Sales by Product Line
SELECT p.productLine, SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM orderdetails od JOIN products p ON od.productCode = p.productCode GROUP BY p.productLine;

-- 1.2
-- Total Quantity Sold by Product Line
SELECT p.productLine, SUM(od.quantityOrdered) AS totalQuantitySold FROM orderdetails od JOIN products p ON od.productCode = p.productCode GROUP BY p.productLine;

-- 2.1
-- Average Sale Amount by Product Line with Filtering
SELECT p.productLine, AVG(od.quantityOrdered * od.priceEach) AS averageSaleAmount FROM orderdetails od JOIN products p ON od.productCode = p.productCode GROUP BY p.productLine HAVING averageSaleAmount > 100; 

-- 3.1
-- Average Population and Total GDP by Continent
SELECT c.Continent, AVG(c.Population) AS averagePopulation, SUM(c.GNP) AS totalGDP FROM country c GROUP BY c.Continent;

-- 3.2
-- Countries with Multiple Official Languages
SELECT co.Code, co.Name, COUNT(*) AS numberOfOfficialLanguages FROM countrylanguage cl JOIN country co ON cl.CountryCode = co.Code WHERE cl.IsOfficial = 'T' GROUP BY co.Code, co.Name HAVING numberOfOfficialLanguages > 3; 
-- 4.1
-- 