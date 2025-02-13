#!/bin/bash

echo "Unzipping data..."
unzip -o /tmp/data.zip -d /tmp/

echo "Cleaning CSVs..."
iconv -f WINDOWS-1252 -t UTF-8 /tmp/data/lafc_fb_data_sample.csv | sed 's/[^[:print:]\t]//g; s/\$//g' > /tmp/data/lafc_fb_data_sample_cleaned.csv

echo "Creating tables..."
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/tables.sql

echo "Creating views..."
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/views.sql

echo "Seeding database..."
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/seed.sql

echo "Database setup complete!"
