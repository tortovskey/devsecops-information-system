import json
import sys
from pathlib import Path


def load_json(path: str):
    report = Path(path)
    if not report.exists():
        print(f"[INFO] Report not found: {path}")
        return None
    with report.open("r", encoding="utf-8") as file:
        return json.load(file)


def check_bandit(path: str) -> bool:
    data = load_json(path)
    if not data:
        return True
    high = [item for item in data.get("results", []) if item.get("issue_severity") == "HIGH"]
    print(f"[INFO] Bandit HIGH findings: {len(high)}")
    return len(high) == 0


def main() -> int:
    if check_bandit("bandit-report.json"):
        print("[PASS] Security gate passed.")
        return 0
    print("[FAIL] Security gate failed.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
