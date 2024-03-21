--1. How many actors are there with the last name 'Wahlberg'
--SELECT first_name,last_name
select count(*) num_actors 
FROM actor
WHERE last_name = 'Wahlberg';

--2. How many payments were made between $3.99 and $5.99
SELECT COUNT(*) AS num_payments
FROM payment
WHERE amount BETWEEN 3.99 AND 5.99;

--3. What film does the store have most of? (search in inventory)
SELECT f.title AS most_in_stock_film, COUNT(*) AS stock_count
FROM inventory i
JOIN film f  ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY stock_count DESC
LIMIT 1;

--4. How many customers have the last name 'William'?
SELECT COUNT(*) AS num_customers
FROM customer
WHERE last_name = 'William';


--5. What store employee (get the id) sold the most rentals?
SELECT r.staff_id AS employee_id, s.first_name, s.last_name, COUNT(*) AS rental_count
FROM rental r
JOIN staff s ON r.staff_id = s.staff_id
GROUP BY r.staff_id, s.first_name, s.last_name 
ORDER BY rental_count DESC
LIMIT 1;

--6. How many different district names are there?
SELECT COUNT(DISTINCT district) AS num_districts
FROM address;


--7. What film has the most actors in it? (use film_actor table and get film_id)
SELECT film_id, COUNT(actor_id) AS num_actors
FROM film_actor
GROUP BY film_id
ORDER BY num_actors DESC
LIMIT 1;


--8. From store_id 1, how many customers have a last name ending with 'es' (use customer table)
SELECT COUNT(*) AS num_customers
FROM customer
WHERE store_id = 1
AND last_name LIKE '%es';


--9. How many payments amounts (4.99, 5.99, etc) had a number of rentals above 250 for customers with ids between 380 and 430?
--    (use group by and having > 250)
SELECT p.amount, COUNT(*) AS rental_count
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.customer_id BETWEEN 380 AND 430
GROUP BY p.amount
HAVING COUNT(*) > 250;

--10. Within the film table, how many rating categories are there? And what rating has the most movies total?
-- Count the number of distinct rating categories
SELECT COUNT(DISTINCT rating) AS num_rating_categories
FROM film;

-- Identify the rating with the most movies total
SELECT rating, COUNT(*) AS num_movies
FROM film
GROUP BY rating
ORDER BY num_movies DESC
LIMIT 1;


