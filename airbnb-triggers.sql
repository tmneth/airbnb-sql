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