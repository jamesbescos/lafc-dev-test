-- Create Tables

-- Events Table
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
    purchase_price DECIMAL(10,2),
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

-- Merch Table
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
    product_size TEXT,
    product_color TEXT,
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


-- Import Data

-- Events Table
COPY events (
    event_name, event_date, event_time, event_day, team, plan_abv, 
    event_report_group, min_events, total_events, fse, season_name, 
    event_name_long, tm_event_name, game_number, add_date, event_id , 
    event_type, arena_name, major_category, minor_category, org_name, 
    plan, season_id
) 
FROM '/tmp/data/lafc_sql_test_events(in).csv' 
DELIMITER ',' 
CSV HEADER;

-- Tickets Table
COPY tickets (
    event_name, section_name, row_name, num_seats, ticket_status, acct_id, 
    price_code, comp_name, purchase_price, ticket_type, price_code_desc, 
    event_id, plan_event_name, tran_type, section_id, row_id, add_datetime, 
    kore_seat_num
) 
FROM '/tmp/data/lafc_sql_test_tickets(in).csv' 
DELIMITER ',' 
CSV HEADER;

-- Manifests Table
COPY manifests (
    manifest_id, section_id, section_name, section_desc, row_id, row_name, 
    row_desc, seat_num, num_seats, last_seat, seat_increment, def_price_code, 
    tm_section_name, tm_row_name, section_info1, section_info2, section_info3, 
    row_info1, arena_name
) 
FROM '/tmp/data/lafc_sql_test_manifest(in).csv' 
DELIMITER ',' 
CSV HEADER;

-- Merch Table
COPY merchandise (
    acct_id, zipcode, optin_flag, optin_date, first_order_date, last_order_date, 
    number_orders, since_date, order_num, order_date, product_id, sku, 
    product_desc1, product_size, product_color, vendor_name, product_department, 
    product_class, status, team_prd, num_items, line_quantity, line_total, 
    price, promo_used_flag, promo_code
) 
FROM '/tmp/data/lafc_sql_test_2021merch(Sheet1).csv' 
DELIMITER ',' 
CSV HEADER;

COPY merchandise (
    acct_id, zipcode, optin_flag, optin_date, first_order_date, last_order_date, 
    number_orders, since_date, order_num, order_date, product_id, sku, 
    product_desc1, product_size, product_color, vendor_name, product_department, 
    product_class, status, team_prd, num_items, line_quantity, line_total, 
    price, promo_used_flag, promo_code
) 
FROM '/tmp/data/lafc_sql_test_2022merch(in).csv' 
DELIMITER ',' 
CSV HEADER;
