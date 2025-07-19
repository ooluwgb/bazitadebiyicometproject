
 # Comet Deployment Engineer Project

This repository contains infrastructure-as-code for deploying resources in AWS, including an EKS cluster and related cloud components. It follows a modular structure to promote reuse, consistency, and clarity.

---

## 📁 Project Structure

```plaintext
.
├── app-{some-app}/
│     └── Resource definitions for specific downstream services or applications.
│         Resources like EKS clusters, which spin up multiple sub-resources, 
│         should be isolated into their own workspace for maintainability.
│
├── base/
│     └── Resource definitions for shared infrastructure, such as:
│           - VPCs
│           - Security Groups
│           - IAM roles
│           - Shared networking components
│
└── modules/
```

### Usage

Each workspace under `app-*` composes the modules to deploy a full environment.
For example, `app-hello-basit-comet` provisions the VPC and EKS cluster used by
the demo application. Deploy the stack with:

```bash
terraform init
terraform apply
```

The resulting outputs include the cluster endpoint and a kubeconfig snippet that
can be written to `~/.kube/config` for direct access. After apply completes, run

```bash
aws eks --region <region> update-kubeconfig --name <cluster-name>
```

to configure `kubectl` against the new cluster.
