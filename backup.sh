set -e #Exit if anyone command exectution failed 

SOURCE_DIR=
TARGET_DIR=
KEEP_NUM_FILES=

echo "==================== CREATE BACKUP ===================="
BACKUP_FILE_NAME=$TARGET_DIR/backup-$(date "+%Y-%m-%d-%H-%M-%S").tar.gz

tar -czf $BACKUP_FILE_NAME $SOURCE_DIR

if [ -f "$BACKUP_FILE_NAME" ]; then
    echo "Backup created: $BACKUP_FILE_NAME"
fi

echo "==================== TESTING CREATED BACKUP ===================="
tar -tzf $BACKUP_FILE_NAME >/dev/null
echo "Testing successfuly completed"

echo "==================== OLD BACKUPS ===================="
BACKUP_LIST=( $( ls $TARGET_DIR/backup*.tar.gz | sort -r -n -t-) )

printf '%s\n' "${BACKUP_LIST[@]}"

echo "==================== REMOVE OLD BACKUPS ===================="
BACKUPS_TO_DELETE=( "${BACKUP_LIST[@]:KEEP_NUM_FILES}" )

for i in "${BACKUPS_TO_DELETE[@]}"
do
    rm -v $i
done
