# LAFC DEV TEST

## DESCRIPTION

Take home test for LAFC analyst position. Instructions in '2025 LAFC Analyst, Business & Data Strategy Project.pdf'.

## REQUIREMENTS

1. Docker
2. Docker Compose

## INSTRUCTIONS

1. Start PostgreSQL container and seed from CSVs
    ```sh
        docker-compose up --build -d
    ```
2. Query the database
    ```sh
        docker exec -it postgres psql -U lafc_user -d lafc_dev -c "SELECT COUNT(*) FROM events;"
    ```
3. Stop the container
    ```sh
        docker-compose down
    ```
