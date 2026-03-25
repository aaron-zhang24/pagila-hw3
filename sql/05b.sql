/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

select f2.title
from film f1
join film_actor fa1 on(f1.film_id = fa1.film_id)
join film_actor fa2 on (fa1.actor_id = fa2.actor_id)
join film f2 on (fa2.film_id = f2.film_id)
where f1.title = 'AMERICAN CIRCUS'
GROUP BY f2.title
HAVING count(*) >= 2
ORDER BY f2.title;
