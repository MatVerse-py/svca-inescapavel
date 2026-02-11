# SVCA Inescapável

**Self‑Verifying Computational Artifact**  
Um primitivo para ciência executável, offline e deterministicamente reproduzível.

[![Reproducible Build](https://github.com/MatVerse-py/svca-inescapavel/actions/workflows/ci.yml/badge.svg)](https://github.com/MatVerse-py/svca-inescapavel/actions/workflows/ci.yml)

## O que é

SVCA (Self‑Verifying Computational Artifact) é um objeto digital que:
- **Contém** o experimento (código + runtime)
- **Prova** sua própria integridade (assinatura Ed25519)
- **Reproduz** os mesmos bytes em qualquer máquina (build determinístico)
- **Executa** offline, sem qualquer infraestrutura externa

Isto inverte o fluxo da ciência computacional:  
**do “paper descreve o experimento”** → **para “o artefato é o experimento”.**

## Uso imediato (com Docker)

```bash
git clone https://github.com/MatVerse-py/svca-inescapavel.git
cd svca-inescapavel

docker build -t svca -f container/Dockerfile .
docker run --rm svca
```

O artefato final estará em `build/module.wasm.br` e sua assinatura em `build/signature.bin`.

## Verificação de reprodutibilidade

```bash
./verify.sh
```

Este script:
1. Verifica a assinatura do manifesto
2. Confere o hash do binário
3. Compara com o hash esperado (garantido pelo `manifest.sha256` assinado)

## Publicação científica

Este repositório acompanha o artigo:

> **SVCA: Self‑Verifying Computational Artifacts – A Primitive for Artifact‑Oriented Science**  
> Disponível em `paper/svca.tex` (pronto para arXiv/SOSP).

O próprio artefato gerado (`build/module.wasm.br`, `build/signature.bin`, `build/manifest.sha256`) pode ser anexado ao PDF como suplemento executável.

## Licença

MIT. Todo código e texto são livres para uso, modificação e citação.
