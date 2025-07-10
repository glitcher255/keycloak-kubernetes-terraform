#!/bin/bash
set -e
# Always run from repo root
cd "$(dirname "$0")/.."

terraform destroy -auto-approve