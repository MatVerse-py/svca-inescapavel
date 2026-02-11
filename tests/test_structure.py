from pathlib import Path


def test_lab_structure_exists():
    required = [
        "src",
        "experiments",
        "tests",
        "artifact",
        "reproducibility",
        "pyproject.toml",
        "verify.sh",
        "build_artifact.py",
        "CONTAINER_DIGEST.md",
        "LAB_POLICY.md",
    ]
    root = Path(__file__).resolve().parents[1]
    for entry in required:
        assert (root / entry).exists(), f"faltando: {entry}"
