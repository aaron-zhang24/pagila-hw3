/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT c.name, rentals.title, rentals."total rentals" 
FROM category c
JOIN LATERAL (
    SELECT f.title, count(rental_id) AS "total rentals"
    FROM film_category fc
    JOIN film f ON (fc.film_id = f.film_id)
    JOIN inventory i ON (f.film_id = i.film_id)
    JOIN rental r ON (r.inventory_id = i.inventory_id)
    WHERE c.category_id = fc.category_id
    GROUP BY f.title, f.film_id
    ORDER BY "total rentals" DESC, f.title ASC
    LIMIT 5 
) AS rentals ON true
ORDER BY c.name, rentals."total rentals" DESC, rentals.title;

