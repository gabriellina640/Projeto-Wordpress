#!/bin/bash

# Container e dados do banco
DB_CONTAINER="wordpress-docker_db_1"
DB_USER="root"
DB_PASS="rootpass"

# Diretórios
BASE_BACKUP="./backups"
DATE=$(date +%Y%m%d_%H%M%S)
DB_BACKUP="$BASE_BACKUP/db/backup_$DATE.sql"
WP_BACKUP="$BASE_BACKUP/wp-content/wp-content_$DATE.zip"

# Cria pastas se não existirem
mkdir -p "$BASE_BACKUP/db"
mkdir -p "$BASE_BACKUP/wp-content"

echo "🔄 Iniciando backup..."

# Backup do banco
if docker exec "$DB_CONTAINER" sh -c "exec mysqldump -u$DB_USER -p$DB_PASS --all-databases" > "$DB_BACKUP"; then
    echo "✅ Banco salvo em: $DB_BACKUP"
else
    echo "❌ Erro ao fazer backup do banco!" >&2
    exit 1
fi

# Backup do wp-content
if zip -r "$WP_BACKUP" wp-content > /dev/null; then
    echo "✅ wp-content salvo em: $WP_BACKUP"
else
    echo "❌ Erro ao zipar wp-content!" >&2
    exit 1
fi

echo "🎉 Backup finalizado com sucesso."

# Upload para Google Drive
echo "☁️ Enviando para o Google Drive..."
rclone copy "$DB_BACKUP" gdrive:wordpress/backups/db
rclone copy "$WP_BACKUP" gdrive:wordpress/backups/wp-content
echo "✅ Backup enviado ao Google Drive."
