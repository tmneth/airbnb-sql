# A view that display all property info
EXPLAIN SELECT * FROM full_property_info WHERE id = 1;

CREATE OR REPLACE VIEW full_property_info AS
SELECT l.*, a.street, a.zip_code, a.latitude, a.longitude, c.city, c2.country
FROM listings l
         INNER JOIN addresses a ON l.address_id = a.id
         INNER JOIN cities c ON a.city_id = c.id
         INNER JOIN countries c2 ON c.country_id = c2.id;

# A view that displays a list of all property reviews
EXPLAIN SELECT * FROM review_list WHERE id = 1;

CREATE OR REPLACE VIEW review_list AS
SELECT l.id, pr.user_id, pr.rating, pr.review_text
FROM listings l
         LEFT JOIN property_reviews pr ON l.id = pr.listing_id;

# A view that displays all property reservations
EXPLAIN SELECT * FROM property_reservation_history WHERE id = 1;

CREATE OR REPLACE VIEW property_reservation_history AS
SELECT l.id, r.start_date, r.end_date, t.total, u.first_name, u.last_name
FROM listings l
         LEFT JOIN reservations r ON l.id = r.listing_id
         LEFT JOIN transactions t ON r.transaction_id = t.id
         INNER JOIN users u ON r.user_id = u.id;

# A view that displays all promo codes that are currently valid (not expired) and the total number of transactions that used each promo code:
EXPLAIN SELECT * FROM valid_promo_codes WHERE id = 1;

CREATE OR REPLACE VIEW valid_promo_codes AS
SELECT p.id, p.code, p.discount, p.expiration_date, COUNT(t.id) AS total_transactions
FROM promo_codes p
         LEFT JOIN transactions t ON t.promo_code_id = p.id
WHERE p.expiration_date > CURDATE()
GROUP BY p.id;

# A view that displays the total number of transactions, total amount spent, and average transaction amount for each user:
EXPLAIN SELECT * FROM user_transactions_summary WHERE id = 1;

CREATE OR REPLACE VIEW user_transactions_summary AS
SELECT u.id,
       u.email,
       COUNT(t.id)  AS total_transactions,
       SUM(t.total) AS total_spent,
       AVG(t.total) AS avg_transaction_amount
FROM users u
         INNER JOIN reservations r ON u.id = r.user_id
         INNER JOIN transactions t ON r.transaction_id = t.id
GROUP BY u.id;

# A view that displays the list of all cities along with their country and the number of listings in each city:
EXPLAIN SELECT * FROM city_listings;

CREATE OR REPLACE VIEW city_listings AS
SELECT ct.city, c.country, COUNT(l.id) AS total_listings
FROM cities ct
         INNER JOIN countries c ON c.id = ct.country_id
         INNER JOIN addresses a ON a.city_id = ct.id
         LEFT JOIN listings l ON l.address_id = a.id
GROUP BY c.country, ct.city;

# A view that displays the list of all active users:
CREATE OR REPLACE VIEW active_users AS
SELECT u.first_name, u.last_name, u.email, u.phone_number
FROM users u
WHERE u.active = 1;