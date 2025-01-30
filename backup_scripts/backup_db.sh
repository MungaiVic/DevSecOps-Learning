#!/bin/bash

# Variables
DB_NAME="logistify"
BACKUP_DIR="/home/monter/dbbackups/"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/$DB_NAME_$TIMESTAMP.sql.gz"

# Ensuring Backup directory exists
mkdir -p $BACKUP_DIR

# Dump and compress the database
echo "Backing up the database $DB_NAME..."
pg_dump $DB_NAME | gzip > $BACKUP_FILE

# Check if backup succeeded
if [ $? -eq 0 ]; then
    echo "backup completed successfully: $BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi
