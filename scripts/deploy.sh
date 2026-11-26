#!/bin/bash
# deploy.sh: Rebuilds and deploys the application stack

set -e # Exit immediately if a command fails

echo "🚀 Starting Deployment Pipeline..."

# 1. Rebuild and restart containers
echo "🔨 Building images and starting containers..."
docker compose -f ../docker-compose.yaml down
docker compose -f ../docker-compose.yaml build
docker compose -f ../docker-compose.yaml up -d

# 2. Wait for MySQL to initialize
echo "⏳ Waiting 15 seconds for MySQL to be ready..."
sleep 15

# 3. Apply database migrations and collect static files
echo "🗄️ Running Django migrations..."
docker exec movie-app python manage.py migrate

echo "🎨 Collecting static files..."
docker exec movie-app python manage.py collectstatic --no-input

echo "✅ Deployment Successful! Application is live."