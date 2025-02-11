#!/bin/bash

echo "Unzipping data..."
unzip -o /tmp/data.zip -d /tmp/

echo "Seeding database..."
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/seed.sql
