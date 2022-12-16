DROP SCHEMA IF EXISTS airbnb;
CREATE SCHEMA airbnb;
USE
airbnb;

--
-- Table structure for table `users`
--

CREATE TABLE users
(
    id                INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name        VARCHAR(45)  NOT NULL,
    last_name         VARCHAR(45)  NOT NULL,
    email             VARCHAR(255) NOT NULL,
    email_verified_at DATETIME     NOT NULL,
    phone_number      VARCHAR(255) NOT NULL,
    password          VARCHAR(255) NOT NULL,
    created_at        DATETIME     NOT NULL,
    updated_at        DATETIME     NOT NULL,
    active            BOOLEAN      NOT NULL DEFAULT TRUE,
    description       TEXT         NOT NULL,
    profile_image     VARCHAR(255) NOT NULL,
);

--
-- Table structure for table `listings`
--

CREATE TABLE listings
(
    id              INTEGER PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(255)   NOT NULL,
    description     TEXT           NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    property_type   VARCHAR(255)   NOT NULL,
    property_size   DECIMAL(10, 2) NOT NULL,
    total_bedrooms  INTEGER        NOT NULL,
    total_bathrooms INTEGER        NOT NULL,
    FOREIGN KEY (address_id) REFERENCES addresses (addresss_id),
    FOREIGN KEY (country_id) REFERENCES countries (country_id),
    FOREIGN KEY (city_id) REFERENCES cities (city_id),
    latitude        VARCHAR(50)    NOT NULL,
    longitude       VARCHAR(50)    NOT NULL,
    start_date      DATETIME       NOT NULL,
    end_date        DATETIME       NOT NULL,
    price           DECIMAL(10, 2) NOT NULL,
    created         DATETIME       NOT NULL,
    modified        DATETIME       NOT NULL,

);

--
-- Table structure for table `countries`
--

CREATE TABLE countries
(
    id      INTEGER PRIMARY KEY AUTO_INCREMENT,
    country VARCHAR(50) NOT NULL,
);

--
-- Table structure for table `cities`
--

CREATE TABLE cities
(
    id   INTEGER PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(50) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries (country_id),
)


--
-- Table structure for table `addresses`
--

CREATE TABLE addresses
(
    id          INTEGER PRIMARY KEY AUTO_INCREMENT,
    address     VARCHAR(50) NOT NULL,
    district    VARCHAR(20) NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities (city_id),
    postal_code VARCHAR(10) DEFAULT NULL,
)

--
-- Table structure for table `transactions`
--


--
-- Table structure for table `promo-codes`
--


--
-- Table structure for table `property-reviews`
--


--
-- Table structure for table `reservations`
--
--
-- CREATE TABLE reservations
-- (
--     id         INTEGER PRIMARY KEY AUTO_INCREMENT,
--     user_id    INTEGER NOT NULL,
--     listing_id INTEGER NOT NULL,
--     start_date DATE    NOT NULL,
--     end_date   DATE    NOT NULL,
--     FOREIGN KEY (user_id) REFERENCES users (id),
--     FOREIGN KEY (listing_id) REFERENCES listings (id)
-- );
