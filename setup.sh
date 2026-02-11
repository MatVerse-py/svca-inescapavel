#!/usr/bin/env bash
set -euo pipefail

python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt

python3 -m pip freeze > requirements-lock.txt

chmod +x verify.sh

git rev-parse HEAD > BUILD_COMMIT

echo "✅ Ambiente Python preparado e congelado em requirements-lock.txt"
echo "✅ Commit de build registrado em BUILD_COMMIT"
