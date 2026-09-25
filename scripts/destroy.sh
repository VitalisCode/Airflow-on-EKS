#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-dev}"
if [[ $# -gt 0 ]]; then
  shift
fi
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TF_DIR="${ROOT_DIR}/terraform"
TFVARS="${TF_DIR}/envs/${ENVIRONMENT}.tfvars"

if [[ ! -f "${TFVARS}" ]]; then
  echo "Unknown environment: ${ENVIRONMENT}" >&2
  exit 1
fi

terraform -chdir="${TF_DIR}" init \
  -backend-config="key=airflow-on-eks/${ENVIRONMENT}/terraform.tfstate"
terraform -chdir="${TF_DIR}" destroy -var-file="${TFVARS}" "$@"
