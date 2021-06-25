-- Recomendation Astronaut Film
select count(title)
from film
where lower(description) like '%stron%';

-- Film with replacement cost between 5$ - 15$ and have rating R
select count(title) as total
from film
where replacement_cost between 5 and 15 and rating = 'R';

-- Total amount processed by each staff member
select staff_id, count(payment_id) as total_trx, sum(amount) as total_amount
from payment
group by staff_id
order by total_amount desc

-- Average replacement cost of movies by rating
select rating, round(avg(replacement_cost),2) as average_cost
from film
group by rating
order by average_cost DESC

-- 5 customers who have spent the most money
select concat(c.first_name,' ',c.last_name) as name, c.email, sum(p.amount) as total_amount
from payment p
left join customer c
on p.customer_id = c.customer_id
group by name, c.email
order by total_amount desc
limit 5

-- total copy of film by store
select i.store_id, f.title, count(i.film_id) as copies
from inventory i 
left join film f
on f.film_id = i.film_id
group by i.store_id, f.title
order by f.title, copies desc

-- Customer who has 40 transaction payments
with platinum as (
	select customer_id, count(customer_id) as total_trx
	from payment
	group by customer_id
	)
select concat(c.first_name,' ',c.last_name) as CC_candidates,  c.email
from platinum p
left join customer c
on p.customer_id = c.customer_id
where total_trx >= 40
