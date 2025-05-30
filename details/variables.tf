variable "service_name" {
  type        = string
  description     = "service name for details microservice"
  default = "details"
}
variable "service_account_name" {
  type        = string
  description = "service account name for details microservice"
  default     = "bookinfo-details"
}
variable "deployment_name" {
  type        = string
  description = "deployment name for details microservice"
  default     = "details-v1"
}