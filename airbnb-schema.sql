DROP SCHEMA IF EXISTS airbnb;
CREATE SCHEMA airbnb;
USE airbnb;

-- https://dev.mysql.com/doc/refman/8.0/en/timestamp-initialization.html
CREATE TABLE users
(
    id        INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
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
    id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    country    VARCHAR(255) NOT NULL,
    created    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE cities
(
    id    INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    city       VARCHAR(255)     NOT NULL,
    country_id INTEGER UNSIGNED NOT NULL,
    created    TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified   TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries (id)
);

CREATE TABLE addresses
(
    id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    city_id    INTEGER UNSIGNED NOT NULL,
    street     VARCHAR(255)     NOT NULL,
    zip_code   VARCHAR(255)     NOT NULL,
    latitude   VARCHAR(50)      NOT NULL,
    longitude  VARCHAR(50)      NOT NULL,
    created    TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified   TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES cities (id)
);

CREATE TABLE listings
(
    id      INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title           VARCHAR(255)     NOT NULL,
    host_id         INTEGER UNSIGNED NOT NULL,
    address_id      INTEGER UNSIGNED NOT NULL,
    description     TEXT             NOT NULL,
    property_type   VARCHAR(255)     NOT NULL,
    total_bedrooms  INTEGER UNSIGNED NOT NULL,
    total_bathrooms INTEGER UNSIGNED NOT NULL,
    total_beds      INTEGER UNSIGNED NOT NULL,
    price           DECIMAL(10, 2)   NOT NULL,
    created         TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified        TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users (id),
    FOREIGN KEY (address_id) REFERENCES addresses (id)
);

CREATE TABLE promo_codes
(
    id   INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    code            VARCHAR(255)   NOT NULL,
    discount        DECIMAL(10, 2) NOT NULL,
    expiration_date DATE           NOT NULL,
    created         TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE transactions
(
    id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    promo_code_id  INTEGER UNSIGNED,
    total          DECIMAL(10, 2) NOT NULL,
    created        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (promo_code_id) REFERENCES promo_codes (id)
);

CREATE TABLE reservations
(
    id             INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    user_id        INTEGER UNSIGNED NOT NULL,
    listing_id     INTEGER UNSIGNED NOT NULL,
    transaction_id INTEGER UNSIGNED NOT NULL,
    start_date     DATETIME         NOT NULL,
    end_date       DATETIME         NOT NULL,
    created        TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified       TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (listing_id) REFERENCES listings (id),
    FOREIGN KEY (transaction_id) REFERENCES transactions (id)
);

CREATE TABLE property_reviews
(
    id          INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    user_id     INTEGER UNSIGNED NOT NULL,
    listing_id  INTEGER UNSIGNED NOT NULL,
    rating      INTEGER UNSIGNED NOT NULL,
    review_text TEXT,
    created     TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified    TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (listing_id) REFERENCES listings (id)
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
    FOREIGN KEY (listing_id) REFERENCES listings (id)
);

