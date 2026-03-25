/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

SELECT a1.actor_id, a1.first_name, a1.last_name, top_films.film_id, top_films.title, top_films.rank, top_films.revenue
FROM actor a1
JOIN LATERAL (
    SELECT fa1.film_id, f1.title, sum(p1.amount) AS revenue,
        RANK() OVER (ORDER BY sum(p1.amount) DESC, fa1.film_id ASC) AS rank
    FROM film_actor fa1
    JOIN film f1 ON (fa1.film_id = f1.film_id)
    JOIN inventory i1 ON (i1.film_id = f1.film_id)
    JOIN rental r1 ON (r1.inventory_id = i1.inventory_id)
    JOIN payment p1 ON (r1.rental_id = p1.rental_id)
    WHERE a1.actor_id = fa1.actor_id
    GROUP BY fa1.film_id, f1.title
    ORDER BY revenue DESC, fa1.film_id ASC
    LIMIT 3
) AS top_films ON true
ORDER BY a1.actor_id, top_films.rank;
