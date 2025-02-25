-- Challenge - Joining on multiple tables
-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1.List the number of films per category.
use sakila;

select c.name as "name of category" , count(f.film_id) as "number of films"
from category as c
join film_category as f
on c.category_id = f.category_id
group by c.name;

-- 2.Retrieve the store ID, city, and country for each store.
-- store , city, country

select s.store_id , co.country, c.city
from store as s
join address as a
on a.address_id = s.address_id
join city as c
on c.city_id= a.city_id
join country as co
on co.country_id = c.country_id;

-- 3.Calculate the total revenue generated by each store in dollars.
select s.store_id, sum(p.amount) as "total revenue" 
from payment as p
join customer as c
on p.customer_id = c.customer_id
join store as s
on c.store_id = s.store_id
group by s.store_id;

-- 4.Determine the average running time of films for each category.
select c.name as category , avg(f.length) as "average running time"
from category as c
join film_category as fc
on c.category_id = fc.category_id
join film as f
on fc.film_id = f.film_id
group by c.name;

-- 5.Identify the film categories with the longest average running time.
select c.name as category , avg(f.length) as "average running time"
from category as c
join film_category as fc
on c.category_id = fc.category_id
join film as f
on fc.film_id = f.film_id
group by c.name
order by "average running time" ;


-- 6.Display the top 10 most frequently rented movies in descending order.
select f.title, count(*) as "no of rentals"
from film as f
join inventory as i
on f.film_id = i.film_id 
join rental as r
on i.inventory_id = r.inventory_id
group by f.title
order by count(*) desc
limit 10;

-- 7.Determine if "Academy Dinosaur" can be rented from Store 1.
select f.title , s.store_id
from film as f
join inventory as i
on f.film_id = i.film_id
join rental as r
on i.inventory_id = r.inventory_id
join store as s
on i.store_id = s.store_id
where f.title = "Academy Dinosaur" and s.store_id = 1;

-- 8.Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 
-- 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this
 -- information can be obtained using a CASE statement combined with IFNULL."
 
 select distinct(f.title),
 case
	when i.film_id is not null then "Available"
    else "Not Available"
    end as "availability status"
 from film as f
 join inventory as i
 on i.film_id = f.film_id;
 