# Deactivate user account:
CREATE PROCEDURE deactivate_user (IN user_id INTEGER UNSIGNED)
BEGIN
    UPDATE users
    SET active = FALSE
    WHERE id = user_id;
END;

# Activate user account:
CREATE PROCEDURE activate_user (IN user_id INTEGER UNSIGNED)
BEGIN
    UPDATE users
    SET active = TRUE
    WHERE id = user_id;
END;

# Set user's email address as verified:
CREATE PROCEDURE verify_email (IN user_id INTEGER UNSIGNED)
BEGIN
    UPDATE users
    SET email_verified = TRUE
    WHERE id = user_id;
END;

# Update the country column to have the first letter capitalized when a new row is inserted into the countries table:
CREATE TRIGGER update_country_case
AFTER INSERT ON countries
FOR EACH ROW
BEGIN
    UPDATE countries SET country = CONCAT(UPPER(LEFT(NEW.country, 1)), SUBSTRING(NEW.country, 2)) WHERE id = NEW.id;
END;

# Update the city column to have the first letter capitalized when a new row is inserted into the countries table:
CREATE TRIGGER update_country_case
AFTER INSERT ON cities
FOR EACH ROW
BEGIN
    UPDATE cities SET city = CONCAT(UPPER(LEFT(NEW.city, 1)), SUBSTRING(NEW.city, 2)) WHERE id = NEW.id;
END;
