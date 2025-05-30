#!/bin/bash

MYSQL_DATA_DIR="/var/lib/mysql"
BACKUP_DIR="/var/backup/mysql"
MYSQL_TAR_FILE="/var/backup/mysql/bizmates-db.tar"
NUM_OF_THREAD="${NUM_OF_THREAD:-2}"
START_TIME=$(date +%s)

echo "=== RESTORATION OF DB STARTED ==="

# Remove existing MySQL data
echo "Removing existing MySQL files from ${MYSQL_DATA_DIR}..."
rm -rf "${MYSQL_DATA_DIR:?}"/* || { echo "Error: Failed to delete MySQL data"; exit 1; }

# Extract MySQL data
echo "Extracting MySQL data..."
tar -xvf ${MYSQL_TAR_FILE} -C ${MYSQL_DATA_DIR} || { echo "Error: Failed to extract MySQL data"; exit 1; }

# Decompress backup files
echo "Decompressing backup files..."
xtrabackup --decompress --parallel="${NUM_OF_THREAD}" --target-dir="${MYSQL_DATA_DIR}" || { echo "Error: Decompression failed"; exit 1; }

# Remove .qp files
echo "Deleting '*.qp' files from ${MYSQL_DATA_DIR}..."
find "${MYSQL_DATA_DIR}" -type f -name "*.qp" -delete || { echo "Error: Failed to remove .qp files"; exit 1; }

# Prepare the backup (apply logs)
echo "Preparing the backup..."
xtrabackup --prepare --target-dir="${MYSQL_DATA_DIR}" || { echo "Error: Backup preparation failed"; exit 1; }

# Set proper ownership
echo "Setting correct directory ownership..."
chown -R mysql:mysql "${MYSQL_DATA_DIR}" || { echo "Error: Failed to set ownership"; exit 1; }

# Capture the end time
END_TIME=$(date +%s)

# Calculate elapsed time
ELAPSED_TIME=$((END_TIME - START_TIME))

# Convert to human-readable format (HH:MM:SS)
HUMAN_READABLE_TIME=$(date -ud "@$ELAPSED_TIME" +'%H:%M:%S')

echo "=== DB RESTORATION COMPLETED! ==="
echo "Total Execution Time: $HUMAN_READABLE_TIME"
