variable "service_name" {
  type        = string
  description     = "service name for reviews microservice"
  default = "reviews"
}
variable "service_account_name" {
  type        = string
  description = "service account name for reviews microservice"
  default     = "bookinfo-reviews"
}
variable "deployment_name1" {
  type        = string
  description = "deployment name for reviews microservice"
  default     = "reviews-v1"
}
variable "deployment_name2" {
  type        = string
  description = "deployment name for reviews microservice"
  default     = "reviews-v2"
}
variable "deployment_name3" {
  type        = string
  description = "deployment name for reviews microservice"
  default     = "reviews-v3"
}