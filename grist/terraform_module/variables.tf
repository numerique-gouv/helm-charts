variable "namespace" {
  type = string
}
variable "chart_name" {
  type = string
}
variable "chart_version" {
  type    = string
  default = "1.1.0"
}
variable "values" {
  type    = list(string)
  default = []
}
variable "image_repository" {
  type    = string
  default = "gristlabs/grist"
}
variable "image_tag" {
  type    = string
  default = "0.7.9"
}

variable "helm_force_update" {
  type    = bool
  default = false
}
variable "helm_recreate_pods" {
  type    = bool
  default = false
}
variable "helm_cleanup_on_fail" {
  type    = bool
  default = false
}
variable "helm_max_history" {
  type    = number
  default = 0
}
variable "helm_timeout" {
  type    = number
  default = 300
}

variable "limits_cpu" {
  type    = string
  default = null
}
variable "limits_memory" {
  type    = string
  default = null
}
variable "requests_cpu" {
  type    = string
  default = null
}
variable "requests_memory" {
  type    = string
  default = null
}

variable "backup_limits_cpu" {
  type    = string
  default = null
}
variable "backup_limits_memory" {
  type    = string
  default = null
}
variable "backup_requests_cpu" {
  type    = string
  default = null
}
variable "backup_requests_memory" {
  type    = string
  default = null
}
