#!/bin/bash

# Mensagem do commit (se quiser, passa como argumento)
COMMIT_MSG=${1:-"Atualização no projeto"}

# Adiciona tudo (exceto arquivos no .gitignore)
git add .

# Cria o commit
git commit -m "$COMMIT_MSG"

# Envia para o branch main do remoto origin
git push origin main
