-- Total trip

select count(distinct tripid) 
from trips_details ;

select tripid, count(tripid) cnt from trips_details
group by tripid
having count(tripid) > 1;



-- Total drivers

select count(distinct driverid) total_drivers from trips;


-- Total earnings 

select sum(fare) fare from trips;


-- Total Completed trips

select count(distinct tripid) trip from trips;


-- Total searches

select sum(searches) searches from trips_details;


-- Total searches which got estimate

select sum(searches_got_estimate) searches from trips_details;


-- Total searches for quotes

select sum(searches_for_quotes) searches from trips_details;


-- total searches  which got quotes

select sum(searches_got_quotes) searches from trips_details;


-- total driver cancelled 

select count(*) - sum(driver_not_cancelled) searches from trips_details;


-- Total otp entered

select sum(otp_entered) searches from trips_details;


-- Total end ride

select sum(end_ride) Total_end_ride from trips_details;


-- average distance per trip

select avg(distance) average_dis from trips; 


--  average fare per trip

select avg(fare) average_fare from trips; 


-- Distance travelled

select sum(distance) total_distance from trips;


-- which is the most used payment methord

select faremethod , method ,count(faremethod) as Total_count
from trips t
join payment p
on p.id = t.faremethod
group by method
order by Total_count desc
limit 1;


-- highest payment was made through  which instrument

select max(t.fare) highest_payment , t.faremethod , method
from trips t
join payment p
on p.id = t.faremethod;


-- which two location had the most trips  

select loc_from,loc_to, count(distinct tripid) Total_trip 
from trips 
group by loc_from,loc_to
order by count(distinct tripid) desc
LIMIT 2;


-- top 5 earning drivers 


 select * from
 (select *, dense_rank() over (order by total_earning desc) rnk
 from
 (select driverid ,sum(fare) total_earning 
 from trips
 group  by driverid)b)c
 where rnk<6;


-- which duration had more trips

select* from
(select *, rank()  over (order by cnt desc) rnk
from
(select duration,count(distinct tripid) cnt from trips
group by duration)b)c
where rnk = 1;


-- which driver , customer pair had more orders

select* from
(select * , rank() over (order by cnt desc) rnk 
from
(select driverid,custid , count(distinct tripid) cnt
from trips 
group by driverid,custid)b)c
where rnk = 1;


-- search to estimate rate

select sum(searches_got_estimate) * 100.0 / sum(searches) from trips_details ;


-- estimate to search for quote rates 

select sum(searches_got_quotes) * 100.0 / sum(searches) from trips_details;


-- quote acceptance rate

select sum(customer_not_cancelled) * 100.0 / sum(searches) from trips_details;


-- quote booking rate

select sum(driver_not_cancelled) * 100.0 / sum(searches) from trips_details;


-- conversion rate

select sum(otp_entered) * 100.0 / sum(searches) from trips_details;


-- which area got highest trips in which duration

select * from
(select *, rank() over (partition by duration,loc_from order by cnt desc) rnk
from
(select duration,loc_from ,count(distinct tripid) cnt from trips
group by duration,loc_from) a) b
where rnk = 1;


-- which area got the highest fares, cancellation,trips

select * from
(select*, rank() over (order by fare desc) rnk
from
(select loc_from ,sum(fare) fare from trips
group by loc_from)b)c
where rnk = 1  ;

select * from
(select*, rank() over (order by can desc) rnk
from
(select loc_from ,count(*) - sum(driver_not_cancelled) can from trips_details
group by loc_from)b)c
where rnk = 1 ;

select * from
(select*, rank() over (order by can desc) rnk
from
(select loc_from ,count(*) - sum(customer_not_cancelled) can from trips_details
group by loc_from)b)c
where rnk = 1 ;


-- which duration got the higest trips and fares

select * from
(select*, rank() over (order by fare desc) rnk
from
(select duration ,count(distinct tripid) fare from trips
group by loc_from)b)c
where rnk = 1  ;







