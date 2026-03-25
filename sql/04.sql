/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT DISTINCT a.first_name, a.last_name
FROM film_category fc
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
JOIN category c USING(category_id)
WHERE c.name = 'Children'
AND a.actor_id NOT IN (
    SELECT a2.actor_id
    FROM film_category fc2
    JOIN film_actor fa2 USING(film_id)
    JOIN actor a2 USING(actor_id)
    JOIN category c2 USING(category_id)
    WHERE c2.name = 'Horror'
)
ORDER BY a.last_name, a.first_name; 
