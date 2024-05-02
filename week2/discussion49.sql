-- 1
SELECT Name, Continent, Population FROM country;

-- 2
SELECT Name AS 'Country Name', Continent, Population FROM country AS c;

-- 3
SELECT Name, Population FROM country WHERE Continent = 'Europe' AND Population > 10000000;

-- 4
SELECT Name, CountryCode FROM city WHERE CountryCode = 'POL' OR CountryCode = 'BEL';

-- 5
SELECT Name, LifeExpectancy FROM country WHERE Continent = 'South America' ORDER BY LifeExpectancy DESC;

-- 6
SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 5;
