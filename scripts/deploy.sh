#!/bin/bash
set -e
# Always run from repo root
cd "$(dirname "$0")/.."

echo "[+] Installing Ansible collections..."
ansible-galaxy collection install -r ansible/requirements.yml

echo "[+] Installing Ansible K8s Python dependencies..."
python3 -m pip install --upgrade pip
pip install kubernetes openshift

terraform apply -auto-approve
terraform output -raw kube_config > kubeconfig/kubeconfig.yaml

cd ansible

ansible-playbook -i inventory/kube_inventory.yaml playbook.yaml