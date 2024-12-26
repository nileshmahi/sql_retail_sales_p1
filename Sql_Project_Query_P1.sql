-- SQL Retail Sales Analysis - P1

-- Create Table

Create Table retail_sales(
 transactions_id int primary key,
 sale_date date,
 sale_time time,
 customer_id int,	
 gender	varchar(15),
 age int,	
 category varchar(15),
 quantiy int,	
 price_per_unit float,
 cogs float,
 total_sale float
)

select * from retail_sales
limit 10

select count(*) from retail_sales

-- Data Cleaning
select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null

select * from retail_sales
where transactions_id is null
      or
      sale_date is null
      or
      sale_time is null
      or
      customer_id is null
      or
      gender is null
      or
      age is null
      or 
	  category is null
      or
      quantiy is null
      or
      price_per_unit is null
      or 
      cogs is null
      or
      total_sale is null

--
delete from retail_sales
where transactions_id is null
      or
      sale_date is null
      or
      sale_time is null
      or
      customer_id is null
      or
      gender is null
      or
      age is null
      or 
	  category is null
      or
      quantiy is null
      or
      price_per_unit is null
      or 
      cogs is null
      or
      total_sale is null

-- Data Exploration

--How many sales/records we have?

select count(*) as total_sale from retail_sales

-- How many customers we have?

select count(distinct customer_id) as Customers from retail_sales

-- how many categories we have

select distinct category as Categories from retail_sales

-- Data Analysis & Business Key Problem & Answers

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from retail_sales
where sale_date = '2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022:
select * from retail_sales
where category = 'Clothing' and to_char(sale_date,'YYYY-MM') = '2022-11' and quantiy >=4

--3. Write a SQL query to calculate the total sales (total_sale) for each category:
select category, sum(total_sale) as net_sales,count(*) as total_orders from retail_sales
group by category

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:

select round(avg(age),2) as avg_age from retail_sales
where category = 'Beauty'

--5. Write a SQL query to find all transactions where the total_sale is greater than 1000:

select * from retail_sales
where total_sale > 1000

--6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:

select category,gender,count(*) as total_transacations
from retail_sales
group by category, gender
order by category
	
--7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select year,month,avg_sale from (select
	extract(year from sale_date) as year,
    extract(month from sale_date) as month,
    avg(total_sale) as avg_sale,
	rank() over(partition by extract(year from sale_date) order by avg (total_sale)desc)
from retail_sales
group by 1,2) as t1
where rank = 1

--8. Write a SQL query to find the top 5 customers based on the highest total sales :


select customer_id,sum(total_sale) as highest_total_sales  from retail_sales
group by customer_id
order by highest_total_sales desc
limit 5

--9. Write a SQL query to find the number of unique customers who purchased items from each category:


select category,count(distinct customer_id) as Count_unique_Customers
from retail_sales
group by category

--10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_sale 
as
(
select *,
	case
	    when extract (hour from sale_time) < 12 then 'Morning'
	    when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
	    else 'Evening'
	end as Shift
from retail_sales
)
select shift,count(*) as total_orders from hourly_sale
group by shift

-- END of project
















