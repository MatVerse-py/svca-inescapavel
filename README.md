# SVCA Inescapável

Self-Verifying Computational Artifact (SVCA)

A minimal, deterministic, self-contained computational artifact that:
- Reproduces byte-identically
- Verifies offline
- Requires no external infrastructure
- Demonstrates artifact-oriented science

## Core Idea

An experiment should not be described.

It should be executable and self-verifying.

SVCA enforces five invariants:

1. Integrity
2. Executability
3. Public Verifiability
4. Strong Reproducibility
5. Autonomy

If any invariant is removed, the class collapses.

---

## Quick Start

```bash
docker build -f container/Dockerfile -t svca .
docker run --rm svca
```

To verify deterministic build:

```bash
./verify.sh
```

---

## Repository Guarantees

* No timestamps
* No dynamic key generation
* No network calls during build
* No mutable dependencies
* Container pinned by digest
* Toolchains pinned by SHA256
* Rebuild → identical SHA256 capsule

---

## Citation

If used in research:

Mateus. *SVCA: Self-Verifying Computational Artifacts*. 2026.
