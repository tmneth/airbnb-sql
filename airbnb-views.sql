CREATE VIEW active_user_list AS
SELECT user_id, first_name, last_name, email, phone_number, profile_image
FROM users
WHERE active = TRUE;

CREATE VIEW full_property_info AS
SELECT l.*, a.street, a.zip_code, a.latitude, a.longitude, c.city, c2.country
FROM listings l
         INNER JOIN addresses a ON l.address_id = a.address_id
         INNER JOIN cities c ON a.city_id = c.city_id
         INNER JOIN countries c2 ON c.country_id = c2.country_id;

CREATE VIEW review_list AS
SELECT l.listing_id, pr.user_id, pr.rating, pr.review_text
FROM listings l
         LEFT JOIN property_reviews pr ON l.listing_id = pr.listing_id;

CREATE VIEW property_reservation_history AS
SELECT l.listing_id, r.start_date, r.end_date, t.total, u.first_name, u.last_name
FROM listings l
         LEFT JOIN reservations r ON l.listing_id = r.listing_id
         LEFT JOIN transactions t ON r.transaction_id = t.transaction_id
         INNER JOIN users u ON r.user_id = u.user_id;