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
