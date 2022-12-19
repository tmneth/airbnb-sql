DELIMITER $$

# Deactivate user account:
CREATE PROCEDURE deactivate_user(IN user_id INTEGER UNSIGNED)
BEGIN
    UPDATE users
    SET active = FALSE
    WHERE id = user_id;
END $$

# Activate user account:
CREATE PROCEDURE activate_user(IN user_id INTEGER UNSIGNED)
BEGIN
    UPDATE users
    SET active = TRUE
    WHERE id = user_id;
END $$

# Set user's email address as verified:
CREATE PROCEDURE verify_email(IN user_id INTEGER UNSIGNED)
BEGIN
    UPDATE users
    SET email_verified = TRUE
    WHERE id = user_id;
END $$

DELIMITER ;