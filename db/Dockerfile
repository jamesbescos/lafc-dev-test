FROM postgres:latest

# Install unzip
RUN apt-get update && apt-get install -y unzip

# Copy scripts and flat files
COPY datasets/data.zip /tmp/data.zip
COPY init/extract_and_seed.sh /docker-entrypoint-initdb.d/extract_and_seed.sh
COPY migrations/tables.sql /tmp/tables.sql
COPY migrations/views.sql /tmp/views.sql
COPY seed/seed.sql /tmp/seed.sql
