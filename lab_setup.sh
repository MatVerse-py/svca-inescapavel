#!/usr/bin/env bash
set -e

echo "=== MATVERSE SVCA LAB INIT ==="

################################
# 1. IDENTIDADE DO BUILD
################################

echo "Commit:"
git rev-parse HEAD | tee BUILD_COMMIT

date -u +"%Y-%m-%dT%H:%M:%SZ" | tee BUILD_TIMESTAMP


################################
# 2. PYTHON BASELINE
################################

python -m pip install --upgrade pip

if [ -f "pyproject.toml" ]; then
    echo "Installing via pyproject..."
    pip install .
elif [ -f "requirements.txt" ]; then
    echo "Installing via requirements..."
    pip install -r requirements.txt
else
    echo "NO DEPENDENCY FILE FOUND — INTERDIÇÃO"
    exit 1
fi


################################
# 3. CONGELAMENTO CIENTÍFICO
################################

pip freeze > requirements-lock.txt


################################
# 4. VERIFY COMO GATE
################################

chmod +x verify.sh

echo "Running verify..."
./verify.sh


################################
# 5. TESTES
################################

if command -v pytest &> /dev/null; then
    pytest
fi


################################
# 6. DIGEST DO CONTAINER
################################

cat <<EOF2 > CONTAINER_DIGEST.md
Base: Ubuntu 24.04
Python: $(python --version)
Build Commit: $(cat BUILD_COMMIT)
Build Time: $(cat BUILD_TIMESTAMP)
EOF2


################################
# 7. PASTA DE ARTEFATO
################################

mkdir -p artifact


echo "=== LAB READY ==="
