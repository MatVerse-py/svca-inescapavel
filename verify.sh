#!/usr/bin/env bash
set -euo pipefail

cd build

minisign -Vm manifest.sha256 -p ../capsule/pubkey.pem -x signature.bin

echo "Signature valid."

sha256sum -c manifest.sha256

echo "Reproducibility verified."
