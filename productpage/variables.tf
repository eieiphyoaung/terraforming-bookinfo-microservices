variable "service_name" {
  type        = string
  description     = "service name for productpage microservice"
  default = "productpage"
}
variable "service_account_name" {
  type        = string
  description = "service account name for productpage microservice"
  default     = "bookinfo-productpage"
}
variable "deployment_name" {
  type        = string
  description = "deployment name for productpage microservice"
  default     = "productpage-v1"
}