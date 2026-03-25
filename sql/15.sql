/*
 * Find every documentary film that is rated G.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */

SELECT title, actors
FROM nicer_but_slower_film_list
WHERE category = 'Documentary'
  AND rating = 'G'
ORDER BY title;

/*
SELECT documentary_films.title, documentary_films.actors
FROM category c
JOIN LATERAL (
    SELECT f.title, string_agg(initcap(a.first_name) || initcap(a.last_name), ', ' ORDER BY a.first_name, a.last_name) AS actors
    FROM film_category fc
    JOIN film f ON (f.film_id = fc.film_id)
    JOIN film_actor fa ON (f.film_id = fa.film_id)
    JOIN actor a ON (fa.actor_id = a.actor_id)
    WHERE c.category_id = fc.category_id AND f.rating = 'G'
    GROUP BY f.film_id, f.title
) AS documentary_films ON true
WHERE c.name = 'Documentary'
ORDER BY documentary_films.title;
*/
