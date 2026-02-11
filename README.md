# SVCA Inescapável

**Self-Verifying Computational Artifact (SVCA)**

Um primitivo para **ciência executável**, **offline** e **deterministicamente reproduzível**.

[![Reproducible Build](https://github.com/MatVerse-py/svca-inescapavel/actions/workflows/ci.yml/badge.svg)](https://github.com/MatVerse-py/svca-inescapavel/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## Visão geral

SVCA (Self-Verifying Computational Artifact) é um objeto digital que:

- **Contém** o experimento (código + runtime)
- **Prova** sua própria integridade (assinatura Ed25519)
- **Reproduz** os mesmos bytes em qualquer máquina (build determinístico)
- **Executa** sem dependência de infraestrutura externa após clone

Isso inverte o fluxo clássico da ciência computacional:

> de “o paper descreve o experimento”
> para “o artefato é o experimento”.

---

## Quick start

```bash
git clone https://github.com/MatVerse-py/svca-inescapavel.git
cd svca-inescapavel

./build.sh
./verify.sh
```

Ao final, os arquivos principais estarão em `build/`:

- `build/module.wasm`
- `build/manifest.sha256`
- `build/signature.bin`
- `build/manifest.json`

---

## O que o `build.sh` faz

1. Compila `src/module.go` para WASM com flags determinísticas (`-trimpath`, `-buildid=`)
2. Gera `manifest.sha256`
3. Gera `manifest.json` determinístico
4. Gera par de chaves Ed25519 automaticamente (primeira execução local)
5. Assina o manifesto

---

## O que o `verify.sh` valida

1. Verifica assinatura Ed25519 de `manifest.sha256`
2. Verifica o hash SHA256 de `module.wasm`

Se tudo estiver correto, o script encerra com:

```text
✅ Tudo íntegro e reproduzível.
```

---


## Setup científico do laboratório

Antes de qualquer experimento, inicialize e congele o ambiente:

```bash
./setup.sh
```

O script:

1. Atualiza `pip`
2. Instala dependências declaradas em `requirements.txt`
3. Gera `requirements-lock.txt` via `pip freeze`
4. Registra o commit corrente em `BUILD_COMMIT`
5. Garante `verify.sh` executável

---

## Porta de admissão (verify obrigatório)

`verify.sh` é o gate de publicação. Nada deve ser publicado sem `verify` em estado PASS.

---

## Contrato de artefato

Cada execução experimental deve exportar saídas em `artifact/` com o contrato mínimo:

- `bundle.tar.gz`
- `manifest.json`
- `hashes.txt`
- `commit.txt`

Isso mantém a separação entre LAB (mutável) e publisher (imutável).

---
## Execução hermética com Docker (opcional)

```bash
docker build -t svca -f container/Dockerfile .
docker run --rm -v "$PWD:/app" svca bash -lc "cd /app && ./build.sh && ./verify.sh"
```

---

## Estrutura do repositório

```text
svca-inescapavel/
├── .github/workflows/ci.yml
├── capsule/
├── container/
├── paper/
├── src/
├── tools/svca-crypto/
├── build.sh
├── verify.sh
├── toolchain.lock
└── README.md
```

---

## CI de reprodutibilidade

O workflow (`.github/workflows/ci.yml`) executa:

- build em container
- verificação criptográfica + hash
- rebuild em container limpo
- comparação de hash (`diff expected.hash actual.hash`)

---

## Licença

MIT. Consulte [`LICENSE`](LICENSE).
