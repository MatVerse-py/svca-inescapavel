#!/usr/bin/env bash
set -euo pipefail
export LC_ALL=C
export TZ=UTC

ROOT="$(pwd)"
BUILD_DIR="$ROOT/build"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "🔧 Compilando módulo Go (WASM) com flags determinísticas..."
GOOS=js GOARCH=wasm \
go build -trimpath -ldflags="-s -w -buildid=" \
  -o module.wasm "$ROOT/src/module.go"

echo "🗜️ Comprimindo com Brotli nível 11..."
brotli -q 11 module.wasm -o module.wasm.br

echo "📝 Gerando manifesto e assinatura..."
sha256sum module.wasm.br > manifest.sha256
cat > manifest.json <<MANIFEST
{
  "capsule": "module.wasm.br",
  "timestamp": "",
  "signature": "signature.bin",
  "compiler": {
    "go": "1.22.3"
  }
}
MANIFEST
minisign -Sm manifest.sha256 -s "$ROOT/capsule/secret.key"

mv manifest.sha256.minisig signature.bin

echo "✅ Artefato pronto:"
ls -lh module.wasm.br signature.bin manifest.sha256 manifest.json
sha256sum module.wasm.br
