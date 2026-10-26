-- Mobile login ke liye users table me mobile column
USE smart_dairy;

ALTER TABLE users ADD COLUMN mobile VARCHAR(15) NULL;
ALTER TABLE users ADD UNIQUE KEY uq_users_mobile (mobile);

-- Admin ka mobile number set karo (apna number daal sakte ho)
UPDATE users SET mobile = '9999999999' WHERE email = 'admin@smartdairy.com';
