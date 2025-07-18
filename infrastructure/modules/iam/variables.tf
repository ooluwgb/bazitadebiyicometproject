variable "role_name" {
  description = "The name of the iam role"
}

variable "policy_arns" {
  description = "The policy ARNs to be attached to the role"
  type        = list(string)
  default     = []
}

variable "inline_policy" {
  description = "Inline policy to be attached to the role"
  default     = ""
}

variable "max_session_duration" {
  type        = number
  description = "(Optional) The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  default     = 3600
}


variable "assume_role_policy" {
  description = "The trust relationship"
  default     = ""
}

variable "principals" {
  type        = list(string)
  description = "List of arns"
  default     = []
}

variable "path" {
  type        = string
  description = "The path to the role"
  default     = "/"
}

variable "tags" {
  description = "A map of tags to add the the IAM role"
  type        = map(any)
  default     = {}
}