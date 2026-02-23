#!/usr/bin/env bash
set -euo pipefail

# Uso: ./scripts/setup_venv.sh [diretorio_venv]
# Cria um virtualenv em .venv por padrão e instala requirements.txt se presente.

VENV_DIR=${1:-.venv}

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 não encontrado. Instale Python 3." >&2
  exit 1
fi

if ! python3 -c "import venv" >/dev/null 2>&1; then
  echo "módulo venv não disponível. Tente: sudo apt-get install python3-venv" >&2
  exit 1
fi

python3 -m venv "$VENV_DIR"
echo "Virtualenv criado em $VENV_DIR"

"$VENV_DIR/bin/python" -m pip install --upgrade pip setuptools wheel
echo "pip, setuptools e wheel atualizados"

if [ -f requirements.txt ]; then
  echo "Encontrado requirements.txt — instalando dependências..."
  "$VENV_DIR/bin/pip" install -r requirements.txt
  echo "Dependências instaladas"
fi

echo "Pronto. Para ativar, rode: source $VENV_DIR/bin/activate"
