FROM postgres:latest

# Install unzip
RUN apt-get update && apt-get install -y unzip

# Copy scripts
COPY init/extract_and_seed.sh /docker-entrypoint-initdb.d/extract_and_seed.sh
COPY migrations/seed.sql /tmp/seed.sql
COPY data/data.zip /tmp/data.zip
