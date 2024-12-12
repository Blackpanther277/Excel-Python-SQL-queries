use classicmodels;

/* Explore the tables and columns */

select *
from products;




/**********
  Basics Exercises
**********/

#1) Write down sql query to show different countries from customers table
SELECT DISTINCT country
FROM customers;


#2) write a query to show number of cities in customers table
SELECT COUNT(DISTINCT city) AS number_of_cities
FROM customers;

#3) How many of my customers are from London in customers table?
SELECT COUNT(*) AS number_of_customers
FROM customers
WHERE city = 'London';



#4)How many of customers from UK but not from London?
SELECT COUNT(*) AS number_of_customers
FROM customers
WHERE country = 'UK' AND city <> 'London';



#5)Write SQL query to show number of Sales Rep in employees table
SELECT COUNT(*) AS number_of_sales_reps
FROM employees
WHERE jobTitle = 'Sales Rep';

#6) What is the address line2 for the office in San Francisco in offices table?
SELECT addressLine2
FROM offices
WHERE city = 'San Francisco';


#7) What is the largest quantity ordered in orderdetails table?
SELECT MAX(quantityOrdered) AS largest_quantity_ordered
FROM orderdetails;


#8) Whats the highest amount paid on '2003-09-28' in payments table?
SELECT MAX(amount) AS highest_amount_paid
FROM payments
WHERE paymentDate = '2003-09-28';


#9) Which products are avaliable more than 5000 in stock and also has buyprice lower than 25?
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE quantityInStock > 5000 AND buyPrice < 25;



#10) select customers who do not have a credit limit (0.00). 
SELECT *
FROM customers
WHERE creditLimit = 0.00;



#11)  Ask your own question and write a query to answer. Share and discuss with your friends.How many different products are available in stock, and what is their total quantity across all products?
SELECT 
    COUNT(DISTINCT productCode) AS total_products,
    SUM(quantityInStock) AS total_quantity_in_stock
FROM 
    products;


#12) Ask your own question and write a query to answer. Share and discuss with your friends. What is the average buy price of products in each product line?
SELECT 
    productLine, 
    AVG(buyPrice) AS average_buy_price
FROM 
    products
GROUP BY 
    productLine;



#13) Ask your own question and write a query to answer. Share and discuss with your friends.What are the total sales amounts for each product, and which products have generated the highest sales?
SELECT 
    p.productCode, 
    p.productName, 
    SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM 
    products p
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    p.productCode, p.productName
ORDER BY 
    total_sales DESC;



/********** 
Joins and group by Exercises 
**********/


/* 1- Find office information of each employee with their first, lastname, addressLine1, state and their city */
SELECT 
    e.firstName, 
    e.lastName, 
    o.addressLine1, 
    o.state, 
    o.city
FROM 
    employees e
JOIN 
    offices o ON e.officeCode = o.officeCode;


/* 2- How many orders have been placed by Herkku Gifts? */
SELECT COUNT(*) AS number_of_orders
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
WHERE c.customerName = 'Herkku Gifts';

 

/* 3- Write sql query to find total payments for Atelier graphique */
SELECT SUM(p.amount) AS total_payments
FROM payments p
JOIN customers c ON p.customerNumber = c.customerNumber
WHERE c.customerName = 'Atelier graphique';



/* 4- Write sql query find the total payments by date */
SELECT paymentDate, SUM(amount) AS total_payments
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate;



/* 5- Write a query to find the amount paid by each customer. */
SELECT 
    c.customerName, 
    SUM(p.amount) AS total_amount_paid
FROM 
    customers c
JOIN 
    payments p ON c.customerNumber = p.customerNumber
GROUP BY 
    c.customerName
ORDER BY 
    c.customerName;



/* 6- Write sql to find top 10 customers the highest total amount paid */
SELECT 
    c.customerName, 
    SUM(p.amount) AS total_amount_paid
FROM 
    customers c
JOIN 
    payments p ON c.customerNumber = p.customerNumber
GROUP BY 
    c.customerName
ORDER BY 
    total_amount_paid DESC
LIMIT 10;



/* 7- Write a query to find the account representative for each customer.*/
SELECT 
    c.customerName, 
    e.firstName AS representative_first_name, 
    e.lastName AS representative_last_name
FROM 
    customers c
LEFT JOIN 
    employees e ON c.salesRepEmployeeNumber = e.employeeNumber;



/* 8- Write sql query to find the employees who live in Boston */
SELECT *
FROM offices
WHERE LOWER(city) = 'boston';

