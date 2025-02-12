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
    --TODO:
);


/*
    Question 3 

    Please write a query that shows the earliest purchase date for every account ID 
    (the first purchase can be either from tickets or merchandise).
*/
CREATE OR REPLACE VIEW vw_question_3 (
    SELECT 
        acct_id,
        MIN(first_purchase) AS earliest_purchase_date
    FROM (
        SELECT acct_id, MIN(order_date) AS first_purchase
        FROM merchandise
        GROUP BY acct_id
        UNION ALL
        SELECT acct_id, MIN(e.event_date) AS first_purchase
        FROM tickets t
        JOIN events e ON t.event_id = e.event_id
        GROUP BY acct_id
    ) purchases
    GROUP BY acct_id;
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
        t.section_id,
        COUNT(t.ticket_id) * 1.0 / NULLIF(s.capacity, 0) AS sell_through_rate
    FROM tickets t
    JOIN last_match lm ON t.event_id = lm.event_id
    JOIN sections s ON t.section_id = s.section_id
    GROUP BY t.section_id, s.capacity;
);
