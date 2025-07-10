#!/bin/bash
set -e
# Always run from repo root
cd "$(dirname "$0")/.."

echo "[+] Installing Ansible collections..."
ansible-galaxy collection install -r ansible/requirements.txt

echo "[+] Running Ansible playbook..."
ansible-playbook -i ansible/inventory/kube_inventory.yaml ansible/playbook.yaml

terraform apply -auto-approve
terraform output -raw kube_config > kubeconfig/kubeconfig.yaml
cd ansible
ansible-playbook -i inventory/kube_inventory.yaml playbook.yaml