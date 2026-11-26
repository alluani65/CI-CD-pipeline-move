#!/bin/bash
# backup.sh: Dumps and compresses the MySQL database

set -e

BACKUP_DIR="../backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/movie_db_backup_$TIMESTAMP.sql.gz"

echo "⏳ Backing up movie_db from mysql-db container..."

# Execute mysqldump inside the container and pipe the output to gzip on the host
docker exec mysql-db mysqldump -uroot -p $DB_PASSWORD movie_db | gzip > "$BACKUP_FILE"

echo "✅ Backup successfully saved to $BACKUP_FILE"