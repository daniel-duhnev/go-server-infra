variable "project_id" {
  type        = string
  description = "Host project id where Shared VPC will be created."
}

variable "environment" {
  type        = string
  description = "Environment name."
  default     = "dev"
}

variable "subnets" {
  type = map(object({
    region                  = string
    cidr                    = string
    pods_secondary_cidr     = string
    services_secondary_cidr = string
  }))
  description = "Map of subnets."
}

variable "dns_zone_name" {
  type        = string
  description = "Public DNS managed zone name"
  default     = null
}

variable "dns_domain" {
  type        = string
  description = "Public DNS domain - include trailing dot."
  default     = null
}

variable "lb_healthcheck_source_ranges" {
  type = list(string)
  default = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]
}

# Service project variables
variable "service_project_active_id" {
  type        = string
  description = "Service project id for active cluster."
}

variable "service_project_passive_id" {
  type        = string
  description = "Service project id for passive cluster."
}

variable "active_subnet_key" {
  type        = string
  description = "Key in the subnets map to use for the active cluster."
}

variable "passive_subnet_key" {
  type        = string
  description = "Key in the subnets map to use for the passive cluster."
}
