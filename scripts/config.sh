#!/bin/bash
set -e
# Always run from repo root
cd "$(dirname "$0")/.."

terraform apply -auto-approve
terraform output -raw kube_config > kubeconfig/kubeconfig.yaml

cd ansible

ansible-playbook -i inventory/kube_inventory.yaml playbook.yaml