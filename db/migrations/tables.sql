-- Create Tables

-- Events Table
-- Detailed information on upcoming and past events
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_date DATE,
    event_time TIME,
    event_day VARCHAR(3) CHECK (event_day IN ('SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT')),
    team VARCHAR(255),
    plan_abv VARCHAR(10),
    event_report_group VARCHAR(255),
    min_events SMALLINT CHECK (min_events >= 0),
    total_events SMALLINT CHECK (total_events >= min_events),
    fse DECIMAL(10,4),
    season_name VARCHAR(255),
    event_name_long VARCHAR(255),
    tm_event_name VARCHAR(255),
    game_number INT,
    add_date TIME,
    event_type VARCHAR(255),
    arena_name VARCHAR(255),
    major_category VARCHAR(255),
    minor_category VARCHAR(255),
    org_name VARCHAR(255),
    plan VARCHAR(10),
    season_id INT NOT NULL
);

-- Tickets Table
-- Contains all ticket purchases. Successful transactions have a status of A or Active
-- acct_id corresponds to acct_id in merch files
CREATE TABLE tickets (
    ticket_id SERIAL PRIMARY KEY,
    event_name VARCHAR(255),
    section_name VARCHAR(255),
    row_name VARCHAR(255),
    num_seats SMALLINT CHECK (num_seats > 0),
    ticket_status CHAR(255),
    acct_id INT,
    price_code VARCHAR(255),
    comp_name VARCHAR(255),
    purchase_price DECIMAL(10,2) CHECK (purchase_price >= 0),
    ticket_type VARCHAR(255),
    price_code_desc TEXT,
    event_id INT REFERENCES events(event_id) ON DELETE CASCADE,
    plan_event_name VARCHAR(255),
    tran_type VARCHAR(255),
    section_id INT,
    row_id INT,
    add_datetime TIME,
    kore_seat_num INT
);

-- Manifests Table
-- Shows the total number of seats available for MLS Regular Season matches at Banc of CA Stadium
-- Section, row and seat combination correspond to the same fields in the ticket table
CREATE TABLE manifests (
    manifest_id SERIAL,
    section_id INT,
    section_name VARCHAR(255),
    section_desc TEXT,
    row_id INT,
    row_name VARCHAR(255),
    row_desc TEXT,
    seat_num INT,
    num_seats SMALLINT CHECK (num_seats > 0),
    last_seat INT,
    seat_increment INT,
    def_price_code VARCHAR(255),
    tm_section_name VARCHAR(255),
    tm_row_name VARCHAR(255),
    section_info1 VARCHAR(255),
    section_info2 VARCHAR(255),
    section_info3 VARCHAR(255),
    row_info1 VARCHAR(255),
    arena_name VARCHAR(255)
);

-- Merchandise Table
-- Contains merchandise transactions that have occurred in 2022 and 2021
CREATE TABLE merchandise (
    merchandise_id SERIAL PRIMARY KEY,
    acct_id INT,
    zipcode VARCHAR(10),
    optin_flag BOOLEAN NOT NULL DEFAULT FALSE,
    optin_date DATE,
    first_order_date DATE,
    last_order_date DATE,
    number_orders SMALLINT CHECK (number_orders >= 0),
    since_date DATE,
    order_num BIGINT,
    order_date DATE NOT NULL,
    product_id BIGINT,
    sku VARCHAR(255),
    product_desc1 TEXT,
    product_size VARCHAR(255),
    product_color VARCHAR(255),
    vendor_name VARCHAR(255),
    product_department VARCHAR(255),
    product_class VARCHAR(255),
    status VARCHAR(255),
    team_prd VARCHAR(255),
    num_items SMALLINT CHECK (num_items > 0),
    line_quantity SMALLINT CHECK (line_quantity > 0),
    line_total DECIMAL(10,2) CHECK (line_total >= 0),
    price DECIMAL(10,2) CHECK (price >= 0),
    promo_used_flag BOOLEAN NOT NULL DEFAULT FALSE,
    promo_code VARCHAR(255)
);

-- Food and Beverage Table
-- Includes LAFC's food and beverage sales
CREATE TABLE fnb_sales (
    sale_id SERIAL PRIMARY KEY,
    order_status VARCHAR(255),
    event_type VARCHAR(255),
    event_name VARCHAR(255),
    season_name VARCHAR(255),
    source VARCHAR(255),
    order_id INTEGER NOT NULL,
    event_date DATE,
    order_time VARCHAR(255),
    item_price DECIMAL(10,2) CHECK (item_price >= 0),
    quantity INTEGER CHECK (quantity >= 0),
    item_id INTEGER NOT NULL,
    item_name VARCHAR(255),
    processed_date TIMESTAMP,
    item_tax DECIMAL(10,2) CHECK (item_tax >= 0),
    item_type VARCHAR(255),
    vendor_name VARCHAR(255),
    vendor_group VARCHAR(255),
    venue_name VARCHAR(255),
    event_time TIMESTAMP
);
