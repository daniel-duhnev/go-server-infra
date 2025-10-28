variable "project_id" {
  type        = string
  description = "Service Project ID on GCP."
}

variable "rule_name" {
  type        = string
  description = "The policy name that defines here."
}

variable "rule_description" {
  type        = string
  description = "The policy description that defined here."
}

variable "default_rule_action" {
  type        = string
  default     = "allow"
  description = "The default rule that allows/denies all traffic with the lowest priority (2,147,483,647)."
}

variable "rule_type" {
  description = "Type indicates the intended use of the security policy. Possible values are CLOUD_ARMOR and CLOUD_ARMOR_EDGE."
  type        = string
  default     = "CLOUD_ARMOR"
}

variable "layer_7_ddos_defense_enable" {
  description = "(Optional) If set to true, enables Cloud Armor Adaptive Protection for L7 DDoS detection. Cloud Armor Adaptive Protection is only supported in Global Security Policies of type CLOUD_ARMOR. Set this variable `true` for Adaptive Protection Auto Deploy."
  type        = bool
  default     = true
}

variable "layer_7_ddos_defense_rule_visibility" {
  description = "(Optional) Rule visibility can be one of the following: STANDARD - opaque rules. PREMIUM - transparent rules. This field is only supported in Global Security Policies of type CLOUD_ARMOR."
  type        = string
  default     = "STANDARD"
}

variable "redirect_type" {
  description = "The redirect type used here."
  type        = string
  default     = null
}

variable "redirect_target" {
  description = "The redirect target used here."
  type        = string
  default     = null
}

variable "preview_rule" {
  description = "Should rules be in preview mode for debugging."
  type        = bool
  default     = false
}

variable "custom_rules" {
  description = "Custome security rules"
  type = map(object({
    action          = string
    priority        = number
    description     = optional(string)
    preview         = optional(bool, false)
    expression      = string
    redirect_type   = optional(string, null)
    redirect_target = optional(string, null)
    rate_limit_options = optional(object({
      enforce_on_key      = optional(string)
      enforce_on_key_name = optional(string)
      enforce_on_key_configs = optional(list(object({
        enforce_on_key_name = optional(string)
        enforce_on_key_type = optional(string)
      })))
      exceed_action                        = optional(string)
      rate_limit_http_request_count        = optional(number)
      rate_limit_http_request_interval_sec = optional(number)
      ban_duration_sec                     = optional(number)
      ban_http_request_count               = optional(number)
      ban_http_request_interval_sec        = optional(number)
      }),
    {})
    header_action = optional(list(object({
      header_name  = optional(string)
      header_value = optional(string)
    })), [])

    preconfigured_waf_config_exclusion = optional(object({
      target_rule_set = string
      target_rule_ids = optional(list(string), [])
      request_header = optional(list(object({
        operator = string
        value    = optional(string)
      })))
      request_cookie = optional(list(object({
        operator = string
        value    = optional(string)
      })))
      request_uri = optional(list(object({
        operator = string
        value    = optional(string)
      })))
      request_query_param = optional(list(object({
        operator = string
        value    = optional(string)
      })))
    }), { target_rule_set = null })

    preconfigured_waf_config_exclusions = optional(map(object({
      target_rule_set = string
      target_rule_ids = optional(list(string), [])
      request_header = optional(list(object({
        operator = string
        value    = optional(string)
      })))
      request_cookie = optional(list(object({
        operator = string
        value    = optional(string)
      })))
      request_uri = optional(list(object({
        operator = string
        value    = optional(string)
      })))
      request_query_param = optional(list(object({
        operator = string
        value    = optional(string)
      })))
    })), null)

  }))
  default = {}
}
