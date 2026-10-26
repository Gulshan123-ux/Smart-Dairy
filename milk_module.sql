-- Milk Module tables. MySQL me ek baar chalao.
USE smart_dairy;

-- Kisan (SELLER) aur grahak (BUYER), dono ek hi list me, code number ke saath
CREATE TABLE IF NOT EXISTS members (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    code        INT NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    mobile      VARCHAR(15),
    member_type  VARCHAR(10) NOT NULL DEFAULT 'SELLER',  -- SELLER / BUYER
    animal_type  VARCHAR(10) NOT NULL DEFAULT 'BOTH',    -- COW / BUFFALO / BOTH
    status      VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',   -- ACTIVE / INACTIVE
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Rate chart (agle step me use hoga): fat + SNF ke hisaab se rate
CREATE TABLE IF NOT EXISTS rate_chart (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    animal_type VARCHAR(10) NOT NULL,                    -- COW / BUFFALO
    fat         DECIMAL(4,1) NOT NULL,
    snf         DECIMAL(4,1) NOT NULL,
    rate        DECIMAL(8,2) NOT NULL,
    UNIQUE KEY uq_rate (animal_type, fat, snf)
);

-- Kisan ko diya hua advance (agle step me use hoga)
CREATE TABLE IF NOT EXISTS advances (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    member_code  INT NOT NULL,
    amount       DECIMAL(10,2) NOT NULL,
    advance_date DATE NOT NULL,
    note         VARCHAR(255)
);

-- Grahak ko doodh bikri (agle step me use hoga)
CREATE TABLE IF NOT EXISTS milk_sales (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    member_code INT NOT NULL,
    sale_date   DATE NOT NULL,
    shift       VARCHAR(10),
    animal_type VARCHAR(10),
    quantity    DECIMAL(8,2) NOT NULL,
    rate        DECIMAL(8,2) NOT NULL,
    amount      DECIMAL(10,2) NOT NULL,
    paid        DECIMAL(10,2) NOT NULL DEFAULT 0
);
