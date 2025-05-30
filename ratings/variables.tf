variable "service_name" {
  type        = string
  description     = "service name for ratings microservice"
  default = "ratings"
}
variable "service_account_name" {
  type        = string
  description = "service account name for detratingsails microservice"
  default     = "bookinfo-ratings"
}
variable "deployment_name" {
  type        = string
  description = "deployment name for ratings microservice"
  default     = "ratings-v1"
}