#!/bin/bash

# Container do banco
DB_CONTAINER="wordpress-docker_db_1"

# Usuário e senha do banco (root e senha conforme seu docker-compose)
DB_USER="root"
DB_PASS="rootpass"

# Pasta para salvar backups localmente
BACKUP_DIR="./backups"

# Cria pasta de backup se não existir
mkdir -p "$BACKUP_DIR"

# Nome do arquivo com timestamp
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).sql"

# Faz dump do banco dentro do container e salva localmente
docker exec $DB_CONTAINER sh -c "exec mysqldump -u$DB_USER -p$DB_PASS --all-databases" > "$BACKUP_FILE"

echo "Backup criado em: $BACKUP_FILE"
