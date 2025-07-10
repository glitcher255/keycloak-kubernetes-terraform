# AKS + Keycloak Authentication

This project sets up a production-style Kubernetes environment on Azure using AKS. It deploys a Keycloak identity provider with an attached Postgres database and a static website protected by Keycloak authentication.

The goal is to demonstrate Infrastructure-as-Code (IaC) principles using **Terraform**, **Ansible**, **Helm**, and **GitHub Actions** to fully automate provisioning, configuration, and teardown of a cloud-native authentication setup.
<p align="center">
  <img src="/screenshots/keycloak1.png" alt="keycloak"/>
</p>

---

## 🎯 Architecture Overview


Components:
- **AKS**: Azure Kubernetes Service cluster for container orchestration
- **Keycloak**: Open-source identity and access management
- **Postgres**: Used as Keycloak's backend database
- **Static site**: A basic website served with authentication
- **GitHub Actions**: CI/CD for deploy, configure, and teardown
- **Terraform**: Provisions AKS, networking, and related resources
- **Ansible**: Deploys and configures all workloads inside AKS
- **Helm**: Used via Ansible to install Keycloak and Postgres charts

---

## 🧱 Infrastructure Breakdown

| Component   | Provisioned With | Justification |
|-------------|------------------|----------------|
| AKS         | Terraform         | Production-ready managed Kubernetes with Azure-native integration |
| Postgres    | Helm via Ansible  | Reliable Bitnami chart, external DB required by Keycloak |
| Keycloak    | Helm via Ansible  | Open-source, well-documented IAM with OIDC support |
| Static Site | Ansible + K8s     | Simple web frontend protected by Keycloak |
| GitHub Actions | YAML Pipelines | Automates provisioning, configuration, and teardown |

---

## ⚙️ Git Workflow

This project uses a basic Git workflow:

- All changes merged via Pull Requests
- Branches used:
  - `main` – stable deployment
  - `feature/ansible-roles`, `infra/terraform` – implementation
- Commits follow a meaningful format (`feat:`, `fix:`, `infra:`)

---

## 🛠️ Setup and Usage

### Prerequisites

- GitHub repo with configured Terraform Env: TF_TOKEN_app_terraform_io
- Terraform
- Ansible
- kubectl
- helm

### Deployment via script

```
./scripts/deploy.sh
```

### Deployment via GitHub Actions

1. Trigger the `deploy.yml` GitHub Action
2. This will:
   - Run Terraform to provision AKS
   - Output kubeconfig file
   - Run Ansible to deploy Keycloak, Postgres, and the static site

### Configuration via GitHub Actions

Trigger the `configure.yml` workflow to reapply Ansible roles (e.g., config changes)

### Teardown

Trigger the `teardown.yml` GitHub Action to destroy all cloud infrastructure (`terraform destroy`)

---

## 🔐 Authentication Flow

1. User visits site
2. Site redirects to Keycloak login
3. After successful login, user is redirected back
4. Static site confirms the user is authenticated

---

## 📌 Design Decisions

| Decision              | Rationale |
|-----------------------|-----------|
| **Terraform for AKS** | Industry standard for reproducible IaC |
| **Ansible for app config** | Better suited for K8s resource templating and Helm integration |
| **Helm for Keycloak & Postgres** | Provides production-ready templates with sensible defaults |
| **Keycloak + Postgres** | Open-source, flexible, and widely adopted |
| **Static Site + Keycloak** | Demonstrates real-world OAuth flow |
| **No Ingress used** | Simplicity – LoadBalancer services are used instead |
| **GitHub Actions** | Native CI/CD for GitHub, no need for external runners |

---

## 🌱 Future Extensions

- Add Ingress + TLS using cert-manager
- Integrate external IdP (Google, GitHub) with Keycloak
- Add monitoring via Prometheus + Grafana
- OpenTelemetry tracing for Keycloak with Tempo or Jaegar
- Backup/restore capabilities for Postgres

---

## 📁 Project Structure

<pre> 
├───.github
│   └───workflows
│
├───ansible
│   ├───inventory
│   ├───roles
│   │   ├───keycloak
│   │   │   └───tasks
│   │   ├───keycloak_config
│   │   │   └───tasks
│   │   ├───postgres
│   │   │   └───tasks
│   │   └───site
│   │       ├───tasks
│   │       └───templates
│   └───vars
├───kubeconfig
├───modules
│   ├───cluster
│   ├───helm
│   ├───NSG
│   └───vnet
├───scripts
└───site
</pre>
---

## 👤 Author

[Glitcher255](https://github.com/glitcher255)
