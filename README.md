# 🚀 Projeto WordPress com Docker + Backup Automatizado

Este repositório contém um ambiente completo para rodar o WordPress com Docker, além de scripts prontos para **backup automático do banco de dados** e da pasta `wp-content`, com envio direto para o **Google Drive via rclone**.

---

## 📦 Estrutura do Projeto

wordpress-docker/
├── .env # Variáveis de ambiente
├── .gitignore # Arquivos ignorados no Git
├── backup_db.sh # Script de backup do banco MySQL
├── docker-compose.yml # Define WordPress, MySQL e Traefik (opcional)
├── upload_backup.sh # Script para zipar e enviar wp-content pro Drive
├── wp-config.php # Configurações adicionais do WordPress
├── wp-content/ # Seus temas, plugins e uploads
├── backups/ # Backups locais (gerados pelos scripts)
└── git_push.sh # Script auxiliar para commit/push Git


---

## 🛠️ Requisitos

| Ferramenta     | Versão mínima |
|----------------|----------------|
| Docker         | 20.x           |
| Docker Compose | 1.29+          |
| Git            | Qualquer       |
| rclone         | 1.65+          |
| zip/unzip      | Para compressão de `wp-content` |

---

## 🔧 Como usar

### 1. Clone o projeto

```bash
git clone https://github.com/gabriellina640/Projeto-Wordpress.git
cd Projeto-Wordpress

2. Configure os diretórios necessários

mkdir -p db_data backups

3. (Opcional) Restaurar backups do Google Drive
Configure o rclone:

rclone config

Baixe os arquivos:

rclone copy gdrive:wordpress/backups/db ./backups/db --progress
rclone copy gdrive:wordpress/backups/wp-content ./backups/wp-content --progress

Restaure banco (caso tenha dump .sql):

docker exec -i wordpress-docker_db_1 mysql -uroot -prootpass < backups/db/backup_xxxxxx.sql

Descompacte o wp-content:

unzip backups/wp-content/wp-content_xxxxxx.zip -d wp-content/

4. Suba os containers

docker-compose up -d

Acesse o WordPress em: http://localhost:8000
🔁 Backups
✅ Banco de Dados

bash backup_db.sh

    Gera um .sql da base de dados e salva em ./backups/db/.

✅ wp-content (temas, plugins, uploads)

bash upload_backup.sh

    Compacta a pasta wp-content e envia automaticamente para o Google Drive.

☁️ Google Drive com rclone

Os backups serão armazenados automaticamente no seu Google Drive, dentro de:

/wordpress/backups/db
/wordpress/backups/wp-content

Se ainda não configurou o rclone:

rclone config

Siga os passos para logar com sua conta Google e autorizar o acesso.
📤 Atualizar projeto no GitHub

Edite, modifique e depois rode:

bash git_push.sh

👨‍💻 Autor

    Gabriel Henrique

    GitHub

    Projeto voltado para automação e portabilidade com foco em produtividade!

📝 Licença

Este projeto é de uso pessoal, mas você pode adaptar à vontade para seus projetos próprios ou empresariais. Se for usar publicamente, mantenha os créditos. 😉
📌 Dica Final

Se quiser migrar o projeto para produção real, ative o Traefik no docker-compose.yml e configure corretamente o domínio e SSL via Let's Encrypt.
