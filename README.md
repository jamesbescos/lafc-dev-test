# LAFC DEV TEST

## DESCRIPTION
Take home test for LAFC analyst position. Instructions in '2025 LAFC Analyst, Business & Data Strategy Project.pdf'.

## REQUIREMENTS
- Docker
- Docker Compose

## INSTRUCTIONS
1. Start PostgreSQL container and seed from CSVs
    ```sh
        docker-compose up --build -d
    ```
2. Test your connection and that there is data
    ```sh
        docker exec -it postgres psql -U lafc_user -d lafc_dev -c "SELECT COUNT(*) FROM events;"
    ```
    or use your prefered db client (you can connect via 'jdbc:postgresql://localhost:5432/lafc_dev'. Credentials are in 'docker-compose.yml')
3. Answers to the questions are saved as views in the database named the following:
    - vw_question_1
    - vw_question_2
    - vw_question_3
    - vw_question_4
    
    You can see the underlying queries of a view in 'db/migrations/views.sql', or by running the query:
    ```sql
        SELECT definition 
        FROM pg_views 
        WHERE viewname = 'vw_question_1';
    ```
4. Stop the container
    ```sh
        docker-compose down
    ```

## NOTES
- I combined the two merchandise CSVs into a single table for simplicity.
- In the query for question 3, I use the event date for a ticket to estimate the purchase date. I could not find a field that indicated when tickets were actually purchased.
- In the query for question 3, I did not use the 'first_order_date' field of merchandise and instead just used the order date of the merchandise included in the CSVs. I thought that was more in the spirit of the prompt.
- In the query for question 4, I used 'season_name' and 'minor_category' to identify mls regular season games for 2022, but I am not confident it is an accurate way to do so.

## TODO
Since the database was not a core part of this assignment, I took some shortcuts in designing it that I would spend more time in designing:

- Improve data ingestion process (better cleaning, anomolie detection, ect) since I needed to make some concessions to what data types were used.
- Further normalize database (eg. section_name exists multiple tables, ect.)
- Create useful indexes (at this scale it is not particularly necessary)
- Spend more time identifying suitable data types and add missing constraints
