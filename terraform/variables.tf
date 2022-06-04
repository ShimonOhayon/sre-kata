variable "service_name" {
  description = "The App Runner service name"
  type        = string
}

variable "service_port" {
  description = "The App Runner service port"
  type        = number
  default     = 8003

}

variable "service_version" {
  description = "The app version"
  type        = string

}
