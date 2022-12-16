DROP SCHEMA IF EXISTS airbnb;
CREATE SCHEMA airbnb;
USE
airbnb;

--
-- Table structure for table `users`
--

CREATE TABLE users
(
    id                SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
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
    id              SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(255)   NOT NULL,
    user_id         SMALLINT UNSIGNED NOT NULL,
    address_id      SMALLINT UNSIGNED NOT NULL,
    description     TEXT           NOT NULL,
    property_type   VARCHAR(255)   NOT NULL,
    property_size   DECIMAL(10, 2) NOT NULL,
    total_bedrooms  SMALLINT UNSIGNED NOT NULL,
    total_bathrooms SMALLINT UNSIGNED NOT NULL,
    latitude        VARCHAR(50)    NOT NULL,
    longitude       VARCHAR(50)    NOT NULL,
    price           DECIMAL(10, 2) NOT NULL,
    created         DATETIME       NOT NULL,
    modified        DATETIME       NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (address_id) REFERENCES addresses (id),
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
    id         SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    city       VARCHAR(50) NOT NULL,
    country_id SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries (id),
)


--
-- Table structure for table `addresses`
--

CREATE TABLE addresses
(
    id       SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    city_id  SMALLINT UNSIGNED NOT NULL,
    street   VARCHAR(255) NOT NULL,
    zip_code VARCHAR(255) NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities (id)
)

--
-- Table structure for table `reservations`
--

CREATE TABLE reservations
(
    id             SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    user_id        SMALLINT UNSIGNED NOT NULL,
    listing_id     SMALLINT UNSIGNED NOT NULL,
    transaction_id SMALLINT UNSIGNED NOT NULL,
    start_date     DATE     NOT NULL,
    end_date       DATE     NOT NULL,
    start_date     DATETIME NOT NULL,
    end_date       DATETIME NOT NULL,
    created_at     DATETIME NOT NULL,
    updated_at     DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (listing_id) REFERENCES listings (id),
    FOREIGN KEY (transaction_id) REFERENCES transactions (id),
);


--
-- Table structure for table `transactions`
--
CREATE TABLE transactions
(
    id              SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    reservation_id  SMALLINT UNSIGNED NOT NULL,
    amount          DECIMAL(10, 2) NOT NULL,
    payment_method  VARCHAR(255)   NOT NULL,
    promo_code_id   SMALLINT UNSIGNED NOT NULL,
    discount_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations (id),
    FOREIGN KEY (promo_code_id) REFERENCES promo_codes (id),
--     FOREIGN KEY (discount_amount) REFERENCES promo_codes (id),
)

--
-- Table structure for table `promo_codes`
--

CREATE TABLE promo_codes
(
    id              SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    code            VARCHAR(255)   NOT NULL,
    discount        DECIMAL(10, 2) NOT NULL,
    expiration_date DATE           NOT NULL
);

--
-- Table structure for table `property_reviews`
--

CREATE TABLE property_reviews
(
    id         SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    user_id    INTEGER NOT NULL,
    listing_id INTEGER NOT NULL,
    rating     INTEGER NOT NULL,
    comment    TEXT    NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (listing_id) REFERENCES listings (id),
)

--
-- Table structure for table `categories`
--

CREATE TABLE categories
(
    id       SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL,
)

--
-- View structure for view `user_list`
--

--
-- View structure for view `property_list`
--

--
-- View structure for view `property_reviews_list`
--

--
-- View structure for view `reservations_list`
--