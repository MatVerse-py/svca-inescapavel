#!/usr/bin/env bash
set -euo pipefail

cd build

echo "🔐 Verificando assinatura Ed25519..."
minisign -Vm manifest.sha256 -p ../capsule/pubkey.pem -x signature.bin

echo "📦 Verificando hash do binário..."
sha256sum -c manifest.sha256

echo "✅ Tudo íntegro e reproduzível."
