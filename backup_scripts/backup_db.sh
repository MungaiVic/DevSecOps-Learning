#!/bin/bash

source ./.env
# Variables
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/$DB_NAME_$TIMESTAMP.sql.gz"

# Ensuring Backup directory exists
mkdir -p $BACKUP_DIR

# Dump and compress the database
echo "Backing up the database $DB_NAME..."
pg_dump -U "$DB_USER" -h "$DB_HOST" $DB_NAME | gzip > "$BACKUP_FILE"

# Check if backup succeeded
if [ $? -eq 0 ]; then
    echo "backup completed successfully: $BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi

# Delete backups older than 7 days
find "$BACKUP_DIR" -name "${DB_NAME}_*.sql.gz" -type f -mtime +7 -delete
