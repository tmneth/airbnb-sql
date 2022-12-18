# TODO: change '%' to 'localhost' when you copy this code

USE airbnb;

# Create a user that can only use select
CREATE USER 'viewer'@'%' IDENTIFIED BY 'verysecurepassword';
GRANT SELECT ON airbnb.* TO 'viewer'@'%';
GRANT USAGE ON airbnb.* TO 'viewer'@'%';

# Create a user for an accounting department
CREATE USER 'accounting'@'%' IDENTIFIED BY 'muchsecure';
GRANT SELECT ON airbnb.user_transactions_summary TO 'accounting'@'%';
GRANT USAGE ON airbnb.* TO 'accounting'@'%';

# Create a user for an marketing department
CREATE USER 'marketing'@'%' IDENTIFIED BY 'evenmoremuchsecure';
GRANT SELECT ON airbnb.active_users TO 'marketing'@'%';
GRANT SELECT ON airbnb.user_transactions_summary TO 'marketing'@'%';
GRANT USAGE ON airbnb.* TO 'marketing'@'%';

# Create airbnb admin users
CREATE USER 'john'@'%' IDENTIFIED BY 'anotherverysecurepassword';
GRANT ALL PRIVILEGES ON airbnb.* TO 'john'@'%';

CREATE USER 'richard'@'%' IDENTIFIED BY 'yetanotherverysecurepassword';
GRANT ALL PRIVILEGES ON airbnb.* TO 'richard'@'%';