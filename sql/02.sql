/*
 * Compute the country with the most customers in it. 
 */

SELECT country
FROM (
    SELECT country, count(*) AS num_customers
    FROM customer
    JOIN address USING(address_id)
    JOIN city USING(city_id)
    JOIN country USING(country_id)
    GROUP BY country
) AS country_count
GROUP BY country, num_customers
ORDER BY num_customers DESC
LIMIT 1;
