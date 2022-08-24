variable "grist_persistence_size" {
  type    = string
  default = "8Gi"
}

variable "grist_backup_schedule" {
  type        = string
  description = "Backup schedule in cron format. Backups are disable if not provided"
  default     = null
}
variable "grist_backup_s3_endpoint" {
  type    = string
  default = null
}
variable "grist_backup_s3_region" {
  type    = string
  default = null
}
variable "grist_backup_s3_bucket" {
  type    = string
  default = null
}
variable "grist_backup_s3_access_key" {
  type    = string
  default = null
}
variable "grist_backup_s3_secret_key" {
  type    = string
  default = null
}
