# A view that display all property info
CREATE VIEW full_property_info AS
SELECT l.*, a.street, a.zip_code, a.latitude, a.longitude, c.city, c2.country
FROM listings l
         INNER JOIN addresses a ON l.address_id = a.address_id
         INNER JOIN cities c ON a.city_id = c.city_id
         INNER JOIN countries c2 ON c.country_id = c2.country_id
WHERE l.listing_id = ?;

# A view that displays a list of all property reviews
CREATE VIEW review_list AS
SELECT l.listing_id, pr.user_id, pr.rating, pr.review_text
FROM listings l
         LEFT JOIN property_reviews pr ON l.listing_id = pr.listing_id
WHERE l.listing_id = ?;

# A view that displays all property reservations
CREATE VIEW property_reservation_history AS
SELECT l.listing_id, r.start_date, r.end_date, t.total, u.first_name, u.last_name
FROM listings l
         LEFT JOIN reservations r ON l.listing_id = r.listing_id
         LEFT JOIN transactions t ON r.transaction_id = t.transaction_id
         INNER JOIN users u ON r.user_id = u.user_id
WHERE l.listing_id = ?;

# A view that displays all promo codes that are currently valid (not expired) and the total number of transactions that used each promo code:
CREATE VIEW valid_promo_codes_with_transactions AS
SELECT p.promo_code_id, p.code, p.discount, p.expiration_date, COUNT(t.transaction_id) AS total_transactions
FROM promo_codes p
         LEFT JOIN transactions t ON t.promo_code_id = p.promo_code_id
WHERE p.expiration_date > CURDATE()
GROUP BY p.promo_code_id;

# A view that displays the total number of transactions, total amount spent, and average transaction amount for each user:
CREATE VIEW user_transactions_summary AS
SELECT u.user_id,
       u.email,
       COUNT(t.transaction_id) AS total_transactions,
       SUM(t.total)            AS total_spent,
       AVG(t.total)            AS avg_transaction_amount
FROM users u
         INNER JOIN reservations r ON u.user_id = r.user_id
         INNER JOIN transactions t ON r.transaction_id = t.transaction_id
GROUP BY u.user_id;

# A view that displays the list of all cities along with their country and the number of listings in each city:
CREATE VIEW city_listings AS
SELECT ct.city, c.country, COUNT(l.listing_id) AS total_listings
FROM cities ct
         INNER JOIN countries c ON c.country_id = ct.country_id
         INNER JOIN addresses a ON a.city_id = ct.city_id
         LEFT JOIN listings l ON l.address_id = a.address_id
GROUP BY c.country, ct.city;