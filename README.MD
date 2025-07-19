# Bazitadebiyicomet Project

This repository contains a simple Flask web service and supporting Terraform infrastructure.
It also includes GitHub Actions workflows for building, testing and deploying the application.
Helm charts are provided to deploy the application on an EKS cluster.

## Project Structure

- `hello-basit-comet/` – Flask application with Dockerfile and tests
- `infrastructure/` – Terraform code for AWS resources (EKS, VPC, IAM, etc.)
- `.github/workflows/` – CI/CD pipelines for Docker builds and Terraform

## Build Instructions

1. Install Python 3.11 and Docker
2. Install dependencies:
   ```bash
   cd hello-basit-comet
   pip install -r requirements.txt
   ```
3. Run tests locally:
   ```bash
   PYTHONPATH=. pytest -v
   ```
4. Build the container image:
   ```bash
   docker build -t hello-basit-comet:latest hello-basit-comet
   ```

## CI/CD Overview

The project uses GitHub Actions with three workflows:

- **build_and_push.yaml** – tests the Python app, builds a Docker image and pushes it to AWS ECR
- **tf_plan.yaml** – runs `terraform plan` on pull requests and posts the result to the PR
- **tf_apply.yaml** – after merging to `main`, runs a plan and waits for manual approval to apply

These workflows automate testing and infrastructure provisioning in aws.

## Deploying with Helm

The `chart/` directory contains a Helm chart for deploying the Flask application
to an Amazon EKS cluster. The default values expose the service using a
`LoadBalancer` so the application is reachable over the internet.

To install the chart:

```bash
helm install my-app ./chart \
  --set image.repository=<your-docker-image>
```

After deployment, the external address can be obtained via:

```bash
kubectl get svc my-app-bazitadebiyicometproject
```
