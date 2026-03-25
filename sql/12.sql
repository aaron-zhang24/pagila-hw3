/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT c.customer_id, c.first_name, c.last_name 
FROM customer c
JOIN LATERAL (
    SELECT ca.name AS category
    FROM rental r
    JOIN inventory i ON (r.inventory_id = i.inventory_id)
    JOIN film_category fc ON (i.film_id = fc.film_id)
    JOIN category ca ON (ca.category_id = fc.category_id)
    WHERE r.customer_id = c.customer_id
    ORDER BY rental_date DESC
    LIMIT 5
) AS recent_rentals ON true
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING count(*) FILTER (WHERE category = 'Action') >= 3
ORDER BY c.customer_id;
