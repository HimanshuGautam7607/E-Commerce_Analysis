SELECT * FROM e_commerce.sale;
describe sale;
update sale
set order_date=str_to_date(order_date,'%m/%d/%Y');

-- Write a SQL query to list all distinct cities where orders have been shipped.
select distinct city as City from sale;

-- Calculate the total selling price
select sum(list_price*quantity) as Total_selling_price from sale;

-- Calculate the total profit
select sum((list_price-cost_price)*quantity) as Total_profit from sale;

-- Write a query to find all orders from the 'Technology' category 
-- that were shipped using 'Second Class' ship mode, ordered by order date.
select category,ship_mode,order_date from sale
where category="Technology" and ship_mode="Second Class"
group by order_date
order by order_date;

-- Write a query to find the average order value
select round(avg(list_price*quantity),2) as Average_order_value from sale;

-- Find the city with the highest total quantity of products ordered.
select city, sum(quantity) as Total_quantity from sale
group by city
order by Total_quantity desc
limit 1;

-- Orders in each region by quantity in descending order.
select product_id,region,sum(quantity) as Total_quantity from sale
group by product_id,region
order by Total_quantity desc;

-- Write a SQL query to list all orders placed in the first quarter of any year (January to March), 
-- including the selling price for these orders.
select order_id as Order_ID,
(list_price*quantity) as Selling_price,
month(order_date) as Month_number,
monthname(order_date) as Month_name,
quarter(order_date) as Quarter_no from sale
where quarter(order_date)=1
group by Month_name,Order_ID,Selling_price,Month_number,Quarter_no
order by Month_number;

-- Find top 10 highest profit generating products 
select product_id as Products,
(list_price-cost_price)*quantity as Profit from sale
group by Products,Profit
order by Profit desc limit 10;

-- Find top 3 highest selling products in each region
select region,product_id,sum(list_price*quantity) as Total_sales from sale
group by region,product_id
order by Total_sales desc
limit 3;

-- For each category which month had highest sales
select category ,month_no,month_name,Total_sales
from(select category,month(order_date) as month_no,monthname(order_date) as month_name,
     sum(list_price*quantity) as Total_sales,
     ROW_NUMBER() OVER (PARTITION BY category ORDER BY SUM(list_price * quantity) DESC) AS r 
     from sale
     group by category,month_no,month_name) as sale_rank
     where r =1;





