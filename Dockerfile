# Use Python 3.14 to match your local environment
FROM python:3.14-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies required to build mysqlclient
RUN apt-get update && apt-get install -y \
    pkg-config \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the Django project
COPY . /app/

# Create directories for Nginx to mount
RUN mkdir -p /app/static /app/media

EXPOSE 8000

# Start Gunicorn
CMD ["gunicorn", "movieproject.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]