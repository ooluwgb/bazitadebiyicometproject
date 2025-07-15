variable "repositories" {
  description = <<EOT
A map of ECR repositories to create.

Example:
{
  "app1" = {
    image_scan_on_push = true
    max_image_count    = 10
  },
  "app2" = {
    image_scan_on_push = false
    max_image_count    = 20
  }
}
EOT
  type = map(object({
    image_scan_on_push = bool
    max_image_count    = number
  }))
}

variable "tags" {
  description = "Tags to apply to all ECR repositories"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "The name of the ECR repository"
  type        = string
  default     = null
  
}