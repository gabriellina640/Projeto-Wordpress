#!/bin/bash

# Nome do remote no rclone e pasta base no Drive
REMOTE="gdrive:wordpress/backups"

# Pastas locais do projeto
WP_CONTENT_DIR="./wp-content"
DB_BACKUP_DIR="./backups/db"

echo "Baixando backup do banco..."
mkdir -p $DB_BACKUP_DIR
rclone copy $REMOTE/db $DB_BACKUP_DIR --progress || { echo "Falha ao baixar backup do banco"; exit 1; }

echo "Baixando backup do wp-content..."
mkdir -p $WP_CONTENT_DIR
rclone copy $REMOTE/wp-content $WP_CONTENT_DIR --progress || { echo "Falha ao baixar wp-content"; exit 1; }

echo "Extraindo backups compactados (se houver)..."
# Ajuste abaixo se usar arquivos zip ou tar
for file in $DB_BACKUP_DIR/*.zip; do
  [ -f "$file" ] || continue
  unzip -o "$file" -d $DB_BACKUP_DIR
done

for file in $WP_CONTENT_DIR/*.zip; do
  [ -f "$file" ] || continue
  unzip -o "$file" -d $WP_CONTENT_DIR
done

echo "Restaurando banco de dados no container..."
# Ajuste o nome do container do banco aqui
DB_CONTAINER="wordpress-docker_db_1"
# Pega o arquivo SQL mais recente
LATEST_DB_BACKUP=$(ls -t $DB_BACKUP_DIR/*.sql | head -1)

if [ -z "$LATEST_DB_BACKUP" ]; then
  echo "Nenhum backup SQL encontrado em $DB_BACKUP_DIR"
  exit 1
fi

docker exec -i $DB_CONTAINER sh -c "mysql -uroot -prootpass" < "$LATEST_DB_BACKUP" || { echo "Falha ao restaurar o banco"; exit 1; }

echo "Subindo containers Docker..."
docker-compose up -d || { echo "Falha ao subir containers"; exit 1; }

echo "Restauração concluída! Você já pode acessar seu WordPress."
