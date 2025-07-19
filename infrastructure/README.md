
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


