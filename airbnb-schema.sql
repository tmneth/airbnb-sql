DROP SCHEMA IF EXISTS airbnb;
CREATE SCHEMA airbnb;
USE airbnb;

CREATE TABLE users (
    user_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    email_verified_at DATETIME NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    profile_image VARCHAR(255) NOT NULL
);

CREATE TABLE countries (
    country_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    country VARCHAR(50) NOT NULL
);
--
-- Table structure for table `cities`
--

CREATE TABLE cities (
    city_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(50) NOT NULL,
    country_id INTEGER NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries (country_id)
);
--
-- Table structure for table `addresses`
--

CREATE TABLE addresses (
    address_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    city_id INTEGER NOT NULL,
    street VARCHAR(255) NOT NULL,
    zip_code VARCHAR(255) NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities (city_id)
);
--
-- Table structure for table `listings`
--

CREATE TABLE listings (
    listing_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    host_id INTEGER NOT NULL,
    address_id INTEGER NOT NULL,
    description TEXT NOT NULL,
    property_type VARCHAR(255) NOT NULL,
    property_size DECIMAL(10, 2) NOT NULL,
    total_bedrooms INTEGER NOT NULL,
    total_bathrooms INTEGER NOT NULL,
    total_beds INTEGER NOT NULL,
    latitude VARCHAR(50) NOT NULL,
    longitude VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created DATETIME NOT NULL,
    modified DATETIME NOT NULL,
    FOREIGN KEY (host_id) REFERENCES users (user_id),
    FOREIGN KEY (address_id) REFERENCES addresses (address_id)
);
--
-- Table structure for table `promo_codes`
--

CREATE TABLE promo_codes (
    promo_code_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(255) NOT NULL,
    discount DECIMAL(10, 2) NOT NULL,
    expiration_date DATE NOT NULL
);
--
-- Table structure for table `transactions`
--
CREATE TABLE transactions
(
    transaction_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER NOT NULL,
    listing_id INTEGER NOT NULL,
    promo_code_id INTEGER,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (listing_id) REFERENCES listings (listing_id),
    FOREIGN KEY (promo_code_id) REFERENCES promo_codes (promo_code_id)
);
--
-- Table structure for table `reservations`
--

CREATE TABLE reservations (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER NOT NULL,
    listing_id INTEGER NOT NULL,
    transaction_id INTEGER NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (listing_id) REFERENCES listings (listing_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions (transaction_id)
);
--
-- Table structure for table `property_reviews`
--

CREATE TABLE property_reviews (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER NOT NULL,
    listing_id INTEGER NOT NULL,
    rating INTEGER NOT NULL,
    review_text TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (listing_id) REFERENCES listings (listing_id)
);
--
-- Table structure for table `categories`
--

CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL
);
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
