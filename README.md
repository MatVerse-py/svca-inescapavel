# svca-lab

Laboratório de ciência executável com verificação criptográfica e replay determinístico.

## Estrutura

```text
svca-lab/
├── src/
├── experiments/
├── tests/
├── artifact/
├── reproducibility/
├── pyproject.toml
├── verify.sh
├── build_artifact.py
├── CONTAINER_DIGEST.md
└── LAB_POLICY.md
```

## Fluxo operacional

```bash
./lab_setup.sh
python3 build_artifact.py
```

Regras de governança e publicação científica estão em `LAB_POLICY.md`.
