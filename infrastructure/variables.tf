variable environment {
  type        = string
  description = "Defines the target environment in which to deploy the infrastructure. Refer to the /vars directory for environment strategy."
}

variable location {
  type        = string
  default     = "uksouth"
  description = "Defines the target data center in which to deploy the infrastructure. Defaulted to uksouth."
}