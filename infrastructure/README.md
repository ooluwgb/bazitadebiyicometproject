
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
          
          In rare cases where a single, small resource is required, 
          we may directly leverage official AWS Terraform modules.
          Direct resource creation without modules should be considered 
          a last resort to maintain consistency and reduce drift.
