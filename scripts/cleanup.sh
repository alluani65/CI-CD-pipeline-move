#!/bin/bash
# cleanup.sh: Removes unused Docker resources and old backups

echo "🧹 Starting system cleanup..."

# 1. Clean up unused Docker images and stopped containers
echo "🐳 Pruning unused Docker images..."
docker system prune -a -f --volumes

# 2. Delete database backups older than 7 days
BACKUP_DIR="../backups"
if [ -d "$BACKUP_DIR" ]; then
    echo "🗑️ Removing database backups older than 7 days..."
    find "$BACKUP_DIR" -type f -name "*.sql.gz" -mtime +7 -exec rm -f {} \;
else
    echo "⚠️ Backup directory not found. Skipping backup cleanup."
fi

echo "✅ Cleanup complete."