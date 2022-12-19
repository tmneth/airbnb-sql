USE airbnb;

# Validate the email column in the users table to ensure that it is a unique value:
CREATE TRIGGER unique_email
    BEFORE INSERT
    ON users
    FOR EACH ROW
BEGIN
    DECLARE email_count INT;
    SELECT COUNT(*) INTO email_count FROM users WHERE email = NEW.email;
    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
    END IF;
END;

# Prevent the email column in the users table from being updated:
CREATE TRIGGER prevent_email_update
    BEFORE UPDATE
    ON users
    FOR EACH ROW
BEGIN
    IF NEW.email <> OLD.email THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Updating email is not allowed';
    END IF;
END;

# Update the country column to have the first letter capitalized when a new row is inserted into the countries table:
CREATE TRIGGER update_country_case
    AFTER INSERT
    ON countries
    FOR EACH ROW
BEGIN
    UPDATE countries SET country = CONCAT(UPPER(LEFT(NEW.country, 1)), SUBSTRING(NEW.country, 2)) WHERE id = NEW.id;
END;

# Update the city column to have the first letter capitalized when a new row is inserted into the countries table:
CREATE TRIGGER update_cities_case
    AFTER INSERT
    ON cities
    FOR EACH ROW
BEGIN
    UPDATE cities SET city = CONCAT(UPPER(LEFT(NEW.city, 1)), SUBSTRING(NEW.city, 2)) WHERE id = NEW.id;
END;
