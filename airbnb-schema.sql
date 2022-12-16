DROP SCHEMA IF EXISTS airbnb;
CREATE SCHEMA airbnb;
USE
airbnb;

-- https://dev.mysql.com/doc/refman/8.0/en/timestamp-initialization.html
CREATE TABLE users
(
    user_id        INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    first_name     VARCHAR(255) NOT NULL,
    last_name      VARCHAR(255) NOT NULL,
    email          VARCHAR(255) NOT NULL,
    email_verified BOOLEAN               DEFAULT FALSE,
    phone_number   VARCHAR(255),
    password       VARCHAR(255) NOT NULL,
    active         BOOLEAN      NOT NULL DEFAULT TRUE,
    profile_image  VARCHAR(255) NOT NULL,
    created        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE countries
(
    country_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    country    VARCHAR(255) NOT NULL,
    created    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE cities
(
    city_id    INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    city       VARCHAR(255) NOT NULL,
    country_id INTEGER UNSIGNED NOT NULL,
    created    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries (country_id)
);

CREATE TABLE addresses
(
    address_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    city_id    INTEGER UNSIGNED NOT NULL,
    street     VARCHAR(255) NOT NULL,
    zip_code   VARCHAR(255) NOT NULL,
    latitude   VARCHAR(50)  NOT NULL,
    longitude  VARCHAR(50)  NOT NULL,
    created    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES cities (city_id)
);

CREATE TABLE listings
(
    listing_id      INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title           VARCHAR(255)   NOT NULL,
    host_id         INTEGER UNSIGNED NOT NULL,
    address_id      INTEGER UNSIGNED NOT NULL,
    description     TEXT           NOT NULL,
    property_type   VARCHAR(255)   NOT NULL,
    total_bedrooms  INTEGER UNSIGNED NOT NULL,
    total_bathrooms INTEGER UNSIGNED NOT NULL,
    total_beds      INTEGER UNSIGNED NOT NULL,
    price           DECIMAL(10, 2) NOT NULL,
    created         TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users (user_id),
    FOREIGN KEY (address_id) REFERENCES addresses (address_id)
);

CREATE TABLE promo_codes
(
    promo_code_id   INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    code            VARCHAR(255)   NOT NULL,
    discount        DECIMAL(10, 2) NOT NULL,
    expiration_date DATE           NOT NULL,
    created         TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE transactions
(
    transaction_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    promo_code_id  INTEGER UNSIGNED,
    total          DECIMAL(10, 2) NOT NULL,
    created        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (promo_code_id) REFERENCES promo_codes (promo_code_id)
);

CREATE TABLE reservations
(
    id             INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    user_id        INTEGER UNSIGNED NOT NULL,
    listing_id     INTEGER UNSIGNED NOT NULL,
    transaction_id INTEGER UNSIGNED NOT NULL,
    start_date     DATETIME  NOT NULL,
    end_date       DATETIME  NOT NULL,
    created        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (listing_id) REFERENCES listings (listing_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions (transaction_id)
);

CREATE TABLE property_reviews
(
    id          INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    user_id     INTEGER UNSIGNED NOT NULL,
    listing_id  INTEGER UNSIGNED NOT NULL,
    rating      INTEGER UNSIGNED NOT NULL,
    review_text TEXT,
    created     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (listing_id) REFERENCES listings (listing_id)
);

CREATE TABLE category_types
(
    id       INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(255) NOT NULL,
    created  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE categories
(
    id            INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category_type INTEGER UNSIGNED,
    listing_id    INTEGER UNSIGNED,
    FOREIGN KEY (category_type) REFERENCES category_types (id),
    FOREIGN KEY (listing_id) REFERENCES listings (listing_id)
);

###
views
# view with all non-sensitive information about active users
create view active_user_list as
select user_id, first_name, last_name, email, phone_number, profile_image
from users
where active = true;

#
view with full info about a property
create view full_property_info as
select l.*, a.street, a.zip_code, a.latitude, a.longitude, c.city, c2.country
from listings l
         inner join addresses a on l.address_id = a.address_id
         inner join cities c on a.city_id = c.city_id
         inner join countries c2 on c.country_id = c2.country_id;

#
view with all reviews for every property
create view review_list as
select l.listing_id, pr.user_id, pr.rating, pr.review_text
from listings l
         left join property_reviews pr on l.listing_id = pr.listing_id;


#
view with a property reservation history
create view property_reservation_history as
select l.listing_id, r.start_date, r.end_date, t.total, u.first_name, u.last_name
from listings l
         left join reservations r on l.listing_id = r.listing_id
         left join transactions t on r.transaction_id = t.transaction_id
         inner join users u on r.user_id = u.user_id;
