-- Create the database
CREATE DATABASE ClassicModelsDB;

-- Use the newly created database
USE ClassicModelsDB ;

-- Create the tables
CREATE TABLE productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(255),
    htmlDescription TEXT
);

CREATE TABLE products (
    productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70),
    image VARCHAR(100),
    productLine VARCHAR(50),
    productScale VARCHAR(10),
    productVendor VARCHAR(50),
    productDescription TEXT,
    quantityInStock INT,
    buyPrice DECIMAL(10,2),
    MSRP DECIMAL(10,2),
    FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50),
    firstName VARCHAR(50),
    extension VARCHAR(10),
    email VARCHAR(100),
    officeCode VARCHAR(10),
    reportsTo INT,
    jobTitle VARCHAR(50),
    FOREIGN KEY (officeCode) REFERENCES offices(officeCode),
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber)
);

CREATE TABLE offices (
    officeCode VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(100),
    addressLine2 VARCHAR(100),
    state VARCHAR(50),
    country VARCHAR(50),
    postalCode VARCHAR(15),
    territory VARCHAR(10)
);

CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(100),
    addressLine2 VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50)
);

CREATE TABLE orderdetails (
    orderNumber INT,
    productCode VARCHAR(15),
    quantityOrdered INT,
    priceEach DECIMAL(10,2),
    orderLineNumber SMALLINT,
    PRIMARY KEY (orderNumber, productCode),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
);

CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    status VARCHAR(15),
    comments TEXT,
    customerNumber INT,
    salesRepEmployeeNumber INT,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber),
    FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

CREATE TABLE payments (
    customerNumber INT,
    checkNumber VARCHAR(50),
    paymentDate DATE,
    amount DECIMAL(10,2),
    PRIMARY KEY (customerNumber, checkNumber),
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);
