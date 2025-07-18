variable "name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "lifecycle_count" {
  description = "Number of images to keep in ECR lifecycle policy"
  type        = number
  default     = null
}

variable "tags" {
  description = "Tags to apply to ECR resources"
  type        = map(string)
  default     = {}
}

variable "snapshot" {
  type    = bool
  default = false
}
