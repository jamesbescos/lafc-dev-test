FROM python:3.11-slim

WORKDIR /app

# Copy files and install dependencies
COPY ./pyproject.toml ./poetry.lock ./
RUN pip install poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi
COPY ./src ./src
COPY ./templates ./templates

# Start flask app
CMD ["python", "-m", "src.web_app"]
