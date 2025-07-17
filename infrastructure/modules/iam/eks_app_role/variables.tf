variable "name" {
  description = "Name of IAM role"
  type        = string
}

variable "name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "path" {
  type        = string
  description = "The path to the role"
  default     = "/"
}

variable "description" {
  description = "IAM Role description"
  type        = string
  default     = null
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = null
}


variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "policy_arns" {
  description = "ARNs of any policies to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add the the IAM role"
  type        = map(any)
  default     = {}
}

variable "namespace_service_account" {
  description = "Kubernetes namespace to allow to assume into this IAM role, eg. <namespace>:<service_account>"
  type        = list(string)

  validation {
    condition = alltrue([
      for v in var.namespace_service_account : can(regex(".+:.+$", v))
    ])
    error_message = "The namespace_service_account variable must be in the format <namespace>:<service_account>"
  }
}

variable "allow_human" {
  description = "Allow human to assume to this IAM role using SSO"
  type        = bool
  default     = false
}

variable "github_repo" {
  description = "Allow specific repo for Github Actions pipeline to assume to this IAM role"
  type        = string
  default     = ""
}

variable "github_environments" {
  description = "Restrict this IAM role to workflows on specific environments (specified in github repo settings > environment). Defaults to allow from all environments"
  type        = list(string)
  default     = ["*"]
}