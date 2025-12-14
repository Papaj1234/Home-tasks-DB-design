-- 1
with filmrentals as (
    select 
        f.release_year,f.title,
        count(r.rental_id) as rental_count,
        rank() over (partition by f.release_year order by count(r.rental_id) desc) as rank
    from film f
    join inventory i on f.film_id = i.film_id
    join rental r on i.inventory_id = r.inventory_id
    group by f.release_year, f.title
)
select release_year, title, rental_count
from filmrentals
where rank = 1;

-- 2
select 
    a.first_name,
    a.last_name,
    count(*) as comedy_appearances
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film_category fc on fa.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Comedy'
group by a.actor_id, a.first_name, a.last_name
order by comedy_appearances desc
limit 5;

-- 3
select first_name, last_name
from actor
where actor_id not in (
    select fa.actor_id
    from film_actor fa
    join film_category fc on fa.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
    where c.name = 'Action'
);

-- 4
with categoryrentals as (
    select 
        c.name as category_name,
        f.title,
        count(r.rental_id) as rental_count,
        row_number() over (partition by c.name order by count(r.rental_id) desc) as rank
    from category c
    join film_category fc on c.category_id = fc.category_id
    join film f on fc.film_id = f.film_id
    join inventory i on f.film_id = i.film_id
    join rental r on i.inventory_id = r.inventory_id
    group by c.name, f.title
)
select category_name, title, rental_count
from categoryrentals
where rank <= 3;

-- 5
with yearlydata as (
    select 
        release_year,
        count(*) as films_count
    from film
    group by release_year
)
select 
    release_year,
    films_count,
    sum(films_count) over (order by release_year) as cumulative_total
from yearlydata
order by release_year;

-- 6
select 
    to_char(r.rental_date, 'yyyy-mm') as month,
    round(
        (sum(case when c.name = 'Animation' then 1 else 0 end)::decimal / count(*)) * 100,
        2
    ) as animation_percentage
from rental r
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by to_char(r.rental_date, 'yyyy-mm')
order by month;

-- 7
with actorgenrestats as (
    select 
        a.first_name,
        a.last_name,
        sum(case when c.name = 'Action' then 1 else 0 end) as action_count,
        sum(case when c.name = 'Drama' then 1 else 0 end) as drama_count
    from actor a
    join film_actor fa on a.actor_id = fa.actor_id
    join film_category fc on fa.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
    group by a.actor_id, a.first_name, a.last_name
)
select first_name, last_name
from actorgenrestats
where action_count > drama_count;

-- 8
select 
    cust.first_name,
    cust.last_name,
    sum(p.amount) as total_spent
from customer cust
join payment p on cust.customer_id = p.customer_id
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Comedy'
group by cust.customer_id, cust.first_name, cust.last_name
order by total_spent desc
limit 5;

-- 9
select 
    substring(address from ' ([^ ]+)$') as street_type,
    count(*) as count
from address
group by street_type
order by count desc;

-- 10 -
