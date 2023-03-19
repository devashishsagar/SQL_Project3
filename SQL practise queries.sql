# 1.Write a SQL query to retrieve the first 5 rows from the "customers" table .
use project;
select*from customers
limit 5;


#2. Write a SQL query to retrieve the unique city names from "customers" table sorted in 
#	descending order.
select distinct city from customers
order by city desc; 


# 3. Write a SQL query to get the number of unique city names "offices" table.
select count(distinct(city)) from offices;


#4. Write a SQL query to get the maximum, minimum and average value from the "age" column in
#	the "customers" table.
select max(age) as max_age, min(age) as min_age, avg(age) as avg_age from customers; #no age column in customers


#5. Write a SQL query to get the city names which are present in “offices” table but not in
#	“customer” table.
select distinct(offices.city) from offices
left join customers
on offices.city=customers.city;


#6. Write a SQL query to get the city names which are present in “offices” table as well as in
#	“customer” table.
select distinct(offices.city) from offices
inner join customers
on offices.city=customers.city;


#7. Write a SQL query to get records where city or state is not given in “customer” table and
#	creditlimit is in the range – 80000 to 130000.
select * from customers
where (city is null or state is null) and creditlimit between 80000 and 130000;


#8. Write a SQL query to get the maximum number of orders placed on a particular date and what
#	is that date in orders table.
select orderdate, count(orderdate) from orders
group by orderdate
order by count(orderdate) desc limit 1;


# 9. For the records which we get in previous question(Q8), write a SQL query to get the customer
#	names and their phone numbers.
SELECT c.customername, c.phone
FROM orders o
JOIN customers c ON o.customernumber = c.customernumber
WHERE o.orderdate = (
  SELECT orderdate
  FROM orders
  GROUP BY orderdate
  ORDER BY COUNT(*) DESC
  LIMIT 1
);


#	10. SQL query to get the customer phone number and customer name from customers table
#	where order is either cancelled or disputed in orders table.
select c.customername, c.phone, o.status from orders o
join customers c
On c.customernumber=o.customernumber
where o.status= 'cancelled' or o.status= 'disputed';


# 11. Write a SQL query to get the top 4 highest selling products from orderdetails table.
select productcode, sum(quantityOrdered) from orderdetails
group by productcode
order by sum(quantityOrdered) desc limit 4;


# 12. Write a SQL query to get the count of orders placed by each customer in 2003 and 2004.
SELECT c.customernumber, COUNT(o.ordernumber) AS order_count
FROM customers c
JOIN orders o ON c.customernumber = o.customernumber
WHERE YEAR(o.orderdate) IN (2003, 2004)
GROUP BY o.customernumber;


# 13. Write a SQL query to get the city names from customer table where more than 4 customers
#	reside.
select city, count(city) as city_where_more_than_4_Customer_reside from customers
group by city
having count(city)>4