#!/usr/bin/env bash
set -euo pipefail

export LC_ALL=C
export TZ=UTC

ROOT="$PWD/build"
mkdir -p "$ROOT"
cd "$ROOT"

# Compile Go module deterministically
GOOS=js GOARCH=wasm \
go build -trimpath -ldflags="-s -w -buildid=" \
-o module.wasm ../src/module.go

brotli -q 11 module.wasm -o module.wasm.br

sha256sum module.wasm.br > manifest.sha256

# Sign with static key
minisign -Sm manifest.sha256 -s ../capsule/secret.key

mv manifest.sha256.minisig signature.bin

echo "SVCA capsule built."
sha256sum module.wasm.br
