-- Create Views

/*
    Question 1

    Please write a query that shows all 2022 member (season ticket holder) account IDs and the unique sections that the member has seats in. 
    There should be one row per account and member tickets are flagged with the plan event prefix 22FS.
*/
CREATE OR REPLACE VIEW vw_question_1 (
    -- TODO:
);


/*
    Question 2 

    Please write a query that aggregates total 2021 ticket spend, 2022 ticket spend and merchandise spend by account ID. 
    There should be one row for each unique account ID.
*/
CREATE OR REPLACE VIEW vw_question_2 (
    WITH acct_ticket_spend AS (
        SELECT
            t.acct_id,
            SUM(CASE
                WHEN EXTRACT(YEAR FROM e.event_date) = 2021
                THEN t.purchase_price
                ELSE 0
            END) AS ticket_spend_2021,
            SUM(CASE
                WHEN EXTRACT(YEAR FROM e.event_date) = 2022
                THEN t.purchase_price
                ELSE 0
            END) AS ticket_spend_2022
        FROM tickets t
        LEFT JOIN events e ON t.event_id = e.event_id
        WHERE t.ticket_status IN ('A', 'Active')
            AND t.purchase_price IS NOT NULL
        GROUP BY t.acct_id
    ),
    acct_merch_spend AS (
        SELECT
            m.acct_id,
            COALESCE(SUM(m.line_total), 0) AS merch_spend
        FROM merchandise m
        GROUP BY m.acct_id
    )
    SELECT
        COALESCE(ts.acct_id, ms.acct_id) AS acct_id,
        COALESCE(ts.ticket_spend_2021, 0) AS ticket_spend_2021,
        COALESCE(ts.ticket_spend_2022, 0) AS ticket_spend_2022,
        COALESCE(ms.merch_spend, 0) AS merchandise_spend
    FROM acct_ticket_spend ts
    FULL OUTER JOIN acct_merch_spend ms ON ms.acct_id = ts.acct_id;
);


/*
    Question 3 

    Please write a query that shows the earliest purchase date for every account ID 
    (the first purchase can be either from tickets or merchandise).
*/
CREATE OR REPLACE VIEW vw_question_3 (
    WITH earliest_ticket_purchases AS (
        SELECT
            acct_id,
            MIN(e.event_date) AS first_purchase
        FROM tickets t
        JOIN events e ON t.event_id = e.event_id
        WHERE t.ticket_status IN ('A', 'Active')
        GROUP BY acct_id
    ),
    earliest_merch_purchases AS (
        SELECT
            acct_id,
            MIN(order_date) AS first_purchase
        FROM merchandise
        GROUP BY acct_id
    )
    SELECT 
        acct_id,
        MIN(first_purchase) AS earliest_purchase_date
    FROM (
        SELECT * FROM earliest_ticket_purchases
        UNION ALL
        SELECT * FROM earliest_merch_purchases
    ) purchases
    GROUP BY acct_id
);


/*
    Question 4

    Please write a query that shows the ticket sell through rate by section for the last match of the 2022 regular season 
    (sell through rate = total sales/total manifest seats).
*/
CREATE OR REPLACE VIEW vw_question_4 (
    WITH last_match AS (
        SELECT event_id
        FROM events
        WHERE season_name = '2022 LAFC Season'
            AND minor_category = 'MLS SOCCER'
        ORDER BY event_date DESC 
        LIMIT 1
    ),
    sections AS (
        SELECT
            section_id,
            SUM(COALESCE(num_seats, 0)) AS capacity
        FROM manifests m
        GROUP BY m.section_id
    )
    SELECT 
        s.section_id,
        COUNT(t.ticket_id)::FLOAT / NULLIF(s.capacity, 0) AS sell_through_rate
    FROM sections s
    LEFT JOIN tickets t
        ON t.section_id = s.section_id
        AND t.event_id = (SELECT event_id FROM last_match)
        AND t.ticket_status IN ('A', 'Active')
    GROUP BY s.section_id, s.capacity
);
