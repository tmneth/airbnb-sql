create view active_user_list as
select user_id, first_name, last_name, email, phone_number, profile_image
from users
where active = true;

create view full_property_info as
select l.*, a.street, a.zip_code, a.latitude, a.longitude, c.city, c2.country
from listings l
         inner join addresses a on l.address_id = a.address_id
         inner join cities c on a.city_id = c.city_id
         inner join countries c2 on c.country_id = c2.country_id;

create view review_list as
select l.listing_id, pr.user_id, pr.rating, pr.review_text
from listings l
         left join property_reviews pr on l.listing_id = pr.listing_id;

create view property_reservation_history as
select l.listing_id, r.start_date, r.end_date, t.total, u.first_name, u.last_name
from listings l
         left join reservations r on l.listing_id = r.listing_id
         left join transactions t on r.transaction_id = t.transaction_id
         inner join users u on r.user_id = u.user_id;