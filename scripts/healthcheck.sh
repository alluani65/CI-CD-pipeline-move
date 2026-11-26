#!/bin/bash
# healthcheck.sh: Verifies container states and HTTP endpoints

echo "🏥 Running System Health Checks..."

# 1. Check HTTP Endpoint (Nginx)
if curl -s -f http://localhost:80 > /dev/null; then
    echo "✅ [HTTP] Nginx is routing traffic successfully (Status 200)."
else
    echo "❌ [HTTP] Nginx endpoint is DOWN or returning errors."
fi

# 2. Check Container States
CONTAINERS=("nginx-proxy" "movie-app" "mysql-db")

for container in "${CONTAINERS[@]}"; do
    if docker inspect -f '{{.State.Running}}' "$container" 2>/dev/null | grep -q "true"; then
        echo "✅ [DOCKER] $container is RUNNING."
    else
        echo "❌ [DOCKER] $container is DOWN or MISSING."
    fi
done

echo "🏁 Health check complete."