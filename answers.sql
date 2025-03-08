--  Retrieve all customer details.
select * from customers;


-- List all products with category and price.
select products.product_name,products.category,products.price
from products;

-- Find all orders placed by a specific customer.
select customers.first_name,customers.last_name,products.product_name as order_placed
from customers
join orders
on orders.customer_id=customers.customer_id
join order_details
on order_details.order_id=orders.order_id
join products
on products.product_id=order_details.product_id;

-- Show order details including product names and quantities.
select order_details.order_id,order_details.quantity,products.product_name
from order_details
join products
on products.product_id=order_details.product_id;

-- Get payment details for a specific order.
select order_details.order_id,payments.payment_id,payments.payment_date,payments.payment_method,products.product_name
from payments
join order_details
on order_details.order_id=payments.order_id
join products
on order_details.product_id=products.product_id;


-- 🔹 Intermediate Queries
-- Find the total number of orders placed.
select order_details.order_id,count(order_details.quantity) as total_order_placed
from order_details
group by order_details.order_id;

select count(order_details.order_id) as total_order_placed
from order_details;

-- Get the total revenue from all orders.
select sum(payments.amount_paid) as total_revenue
from payments;


-- List the top 3 most expensive products.
select products.product_name,products.price
from products
order by products.price desc
limit 3;

-- INSERT INTO Payments (payment_id, order_id, payment_date, amount_paid, payment_method, payment_status) VALUES
-- (506, 1001, '2024-03-07', 800, 'Credit Card', 'Completed');


-- Find customers who have made more than one purchase.
select customers.first_name,customers.last_name,count(payments.order_id) as c
from customers
join orders
on orders.customer_id=customers.customer_id
join payments
on payments.order_id=orders.order_id
group by customers.first_name,customers.last_name
having c>1;

-- Retrieve all orders made in March 2024.

SELECT * FROM orders 
WHERE order_date BETWEEN '2024-03-01' AND '2024-03-31';



-- 🔹 Advanced Queries
-- Identify the most frequently purchased product.
select products.product_name,count(payments.order_id) as c
from products
join order_details
on order_details.product_id=products.product_id
join payments
on payments.order_id=order_details.order_id
group by products.product_name
order by c desc;

-- Find customers who haven’t placed any orders.
select customers.first_name,customers.last_name
from customers
join orders
on orders.customer_id=customers.customer_id
join order_details
on order_details.order_id=orders.order_id
where order_details.order_id is null;



-- Get the product with the lowest stock available.
select products.product_name,products.stock
from products
order by products.stock
limit 1;


-- Retrieve customers who have spent more than ₹1000 in total.
select customers.first_name,customers.last_name ,sum(payments.amount_paid) as amount
from customers
join orders
on orders.customer_id=customers.customer_id
join payments
on payments.order_id=orders.order_id
group by customers.first_name,customers.last_name
having amount>1000;


-- Find the most popular payment method used by customers.
select payments.payment_method,count(payments.payment_method) as c
from payments
group by payments.payment_method
order by c desc
limit 1;
