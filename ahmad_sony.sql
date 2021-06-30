--A customer wants to know the films about “astronauts”. How many recommendations could you give for him?--
SELECT COUNT(*) FROM film WHERE description like '%stronaut%'

--I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
SELECT COUNT(*) FROM film WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;

--We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.
--How many payments did each staff member handle? And how much was the total amount processed by each staff member?
SELECT staff_id, COUNT(payment_id) AS num_of_payments, SUM(amount) AS total_amount FROM payment GROUP BY staff_id ORDER BY num_of_payments DESC;

--Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
SELECT rating, AVG(replacement_cost)::NUMERIC(10,2) as rc_avg FROM film GROUP BY rating

--We want to send coupons to the 5 customers who have spent the most amount of money. Get the customer name, email and their spent amount!
SELECT concat(c.first_name,' ',c.last_name) as customer_name, c.email, sum(p.amount) as spent_amount FROM customer as c INNER JOIN payment as p on c.customer_id=p.customer_id 
GROUP BY c.customer_id ORDER BY spent_amount desc limit 5

--We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
SELECT st.store_id, count(inventory_id) as movies FROM store st JOIN inventory i ON st.store_id = i.store_id GROUP BY st.store_id

--We want to know what customers are eligible for our platinum credit card. 
--The requirements are that the customer has at least a total of 40 transaction payments. Get the customer name, email who are eligible for the credit card!
SELECT CONCAT(first_name, ' ', last_name) as customer_name, email, count(amount) as payment_count FROM customer cs 	JOIN payment py ON cs.customer_id = py.customer_id
GROUP BY first_name, last_name, email HAVING count(amount) >= 40
