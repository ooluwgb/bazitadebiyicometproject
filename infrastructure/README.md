
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
    └── Custom Terraform modules used across the project.
        - Encourages reusability
        - Provides consistent architecture patterns
        - In rare cases a small resource may directly use official AWS
          Terraform modules. Direct resource creation should be a last
          resort to avoid drift and maintain consistency.

## Enabling CloudWatch Logs for EKS

The EKS module supports automatic creation of a CloudWatch log group. By
default it is disabled. To enable logging edit the application workspace
(`app-hello-basit-comet/main.tf`) and set `create_cloudwatch_log_group` to
`true`.

If a log group already exists from a previous deployment you may need to
manually delete it before running `terraform apply` again:

```bash
aws logs delete-log-group --log-group-name /aws/eks/comet-eks/cluster
```

After removal, re-run Terraform to recreate the log group and enable control
plane logging.

## Networking and IAM Checks

If worker nodes have trouble reaching the EKS API or pulling container
images, verify the following:

- Private subnets should route `0.0.0.0/0` traffic through a NAT gateway so
  instances can access the internet.
- The worker node security group must allow outbound HTTPS (port `443`).
- The node group IAM role requires the following AWS managed policies:
  `AmazonEKSWorkerNodePolicy`, `AmazonEC2ContainerRegistryReadOnly`,
  `AmazonEKSCNIPolicy` and `AmazonSSMManagedInstanceCore`.
