# LAFC Business and Data Strategy Project

## DESCRIPTION
Take home test for LAFC analyst position. Instructions in '2025 LAFC Analyst, Business & Data Strategy Project.pdf'.

**Please judge part 2 of this project.**

You can see the queries directly in plain text 'db/migrations/views.sql' or you can view and run them by running the docker containers with the instructions below.

Thank you for taking the time to review this! Please reach out if you run into any issues or have any feedback.

## REQUIREMENTS
- Docker
- Docker Compose

## COMPONENTS

### Containers
- PostrgreSQL
    - To host data.
- Python (Flask with embedded Tableau)
    - To serve home page and part 1 submission.
- Jupyter Notebook
    - To serve and provide interactivity for part 2 submission.

## INSTRUCTIONS
1. Start containers and seed db from CSVs
    ```sh
        docker-compose up --build -d
    ```
2.  (Optional) Test your connection and that seeding was successful.
    ```sh
        docker exec -it postgres psql -U lafc_user -d lafc_dev -c "SELECT COUNT(*) FROM events;"
    ```
    or use your prefered db client (you can connect via 'jdbc:postgresql://localhost:5432/lafc_dev'. Credentials are in 'docker-compose.yml')
3.  (Optional) View answers directly in database. Answers to the questions are saved as views in the database named the following:
    - vw_question_1
    - vw_question_2
    - vw_question_3
    - vw_question_4
      
    You can see the underlying queries of a view in 'db/migrations/views.sql', or by running the query:
    ```sql
        SELECT definition 
        FROM pg_views 
        WHERE viewname = '<view name>';
    ```
4. Open browser to 'https://localhost:4444' to view assignment submissions.
5. Stop the containers
    ```sh
        docker-compose down
    ```

## NOTES
- I combined the two merchandise CSVs into a single table for simplicity.
- In the query for question 3, I use the event date for a ticket to estimate the purchase date.
- In the query for question 3, I did not use the 'first_order_date' field of merchandise and instead just used the order date of the merchandise included in the CSVs.
- In the query for question 4, I used 'season_name' and 'minor_category' to identify MLS regular season games for 2022.

## TODO
Since the database was not a core part of this assignment, I took shortcuts in designing it along with some of the decisions I made for the frontend. If I had more time, below are somethings I would like to develop further:

- Improve data ingestion process (better cleaning, anomolie detection, ect.)
- Further normalize database (eg. section_name exists multiple tables, ect.)
- Create useful indexes (at this scale it is not particularly necessary)
- Spend more time identifying suitable data types and add missing constraints
- Better formatting of responses in Jupyter Notebook
- Improved styling, structure and content of home page
