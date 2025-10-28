# Create a simple pre-configred WAF Rule using the GCP Cloud Armor Terraform module
module "security_policy" {
  source  = "GoogleCloudPlatform/cloud-armor/google"
  version = "~> 2.0"

  project_id  = var.project_id
  name        = var.rule_name
  description = var.rule_description

  // Rule actions
  default_rule_action                  = var.default_rule_action
  type                                 = var.rule_type
  layer_7_ddos_defense_enable          = var.layer_7_ddos_defense_enable
  layer_7_ddos_defense_rule_visibility = var.layer_7_ddos_defense_rule_visibility

  // Rule config
  pre_configured_rules = {
    // These are default rules as a starting point.
    "sqli_level2" = {
      action                  = "deny(502)"
      priority                = 1
      redirect_type           = var.redirect_type
      redirect_target         = var.redirect_target
      preview                 = var.preview_rule
      description             = "SQL injection sensitivity level 2"
      target_rule_set         = "sqli-v33-stable"
      sensitivity_level       = 2
      exclude_target_rule_ids = ["owasp-crs-v030301-id942370-sqli", "owasp-crs-v030301-id942340-sqli", "owasp-crs-v030301-id942330-sqli", "owasp-crs-v030301-id942430-sqli", "owasp-crs-v030301-id942260-sqli", "owasp-crs-v030301-id942200-sqli", "owasp-crs-v030301-id942110-sqli"]
    }

    "xss_level2" = {
      action            = "deny(502)"
      priority          = 2
      redirect_type     = var.redirect_type
      redirect_target   = var.redirect_target
      preview           = var.preview_rule
      description       = "Cross-site scripting sensitivity level 2"
      target_rule_set   = "xss-v33-stable"
      sensitivity_level = 2
    }

    "lfi_level2" = {
      action                  = "deny(502)"
      priority                = 3
      redirect_type           = var.redirect_type
      redirect_target         = var.redirect_target
      preview                 = var.preview_rule
      description             = "Local file inclusion sensitivity level 2"
      target_rule_set         = "lfi-v33-stable"
      sensitivity_level       = 2
      exclude_target_rule_ids = ["owasp-crs-v030301-id930130-lfi"]
    }

    "rce_level2" = {
      action                  = "deny(502)"
      priority                = 4
      redirect_type           = var.redirect_type
      redirect_target         = var.redirect_target
      preview                 = var.preview_rule
      description             = "Remote code execution sensitivity level 2"
      target_rule_set         = "rce-v33-stable"
      sensitivity_level       = 2
      exclude_target_rule_ids = ["owasp-crs-v030301-id932200-rce", "owasp-crs-v030301-id932105-rce"]
    }

    "rfi_level2" = {
      action            = "deny(502)"
      priority          = 5
      redirect_type     = var.redirect_type
      redirect_target   = var.redirect_target
      preview           = var.preview_rule
      description       = "Remote file inclusion sensitivity level 2"
      redirect_type     = "GOOGLE_RECAPTCHA"
      target_rule_set   = "rfi-v33-stable"
      sensitivity_level = 2
    }

    "method-enforcement_level2" = {
      action            = "deny(502)"
      priority          = 6
      redirect_type     = var.redirect_type
      redirect_target   = var.redirect_target
      preview           = var.preview_rule
      description       = "Method enforcement sensitivity level 2"
      target_rule_set   = "methodenforcement-v33-stable"
      sensitivity_level = 2
    }

    "scanner-detection_level2" = {
      action                  = "deny(502)"
      priority                = 7
      redirect_type           = var.redirect_type
      redirect_target         = var.redirect_target
      preview                 = var.preview_rule
      description             = "Scanner detection sensitivity level 2"
      target_rule_set         = "scannerdetection-v33-stable"
      sensitivity_level       = 2
      exclude_target_rule_ids = ["owasp-crs-v030301-id913100-scannerdetection"]
    }

    "protocol-attack_level2" = {
      action                  = "deny(502)"
      priority                = 8
      redirect_type           = var.redirect_type
      redirect_target         = var.redirect_target
      preview                 = var.preview_rule
      description             = "Protocol Attack sensitivity level 2"
      target_rule_set         = "protocolattack-v33-stable"
      sensitivity_level       = 2
      exclude_target_rule_ids = ["owasp-crs-v030301-id921150-protocolattack"]
    }

    "php_level2" = {
      action            = "deny(502)"
      priority          = 9
      redirect_type     = var.redirect_type
      redirect_target   = var.redirect_target
      preview           = var.preview_rule
      description       = "PHP sensitivity level 2"
      target_rule_set   = "php-v33-stable"
      sensitivity_level = 2
    }

    "sesion-fixation-level2" = {
      action            = "deny(502)"
      priority          = 10
      redirect_type     = var.redirect_type
      redirect_target   = var.redirect_target
      preview           = var.preview_rule
      description       = "Session fixation sensitivity level 2"
      target_rule_set   = "sessionfixation-v33-stable"
      sensitivity_level = 2
    }

    "java-attack-level2" = {
      action            = "deny(502)"
      priority          = 11
      redirect_type     = var.redirect_type
      redirect_target   = var.redirect_target
      preview           = var.preview_rule
      description       = "Java attack sensitivity level 2"
      target_rule_set   = "java-v33-stable"
      sensitivity_level = 2
    }

    "nodejs-attack-level2" = {
      action            = "deny(502)"
      priority          = 12
      redirect_type     = var.redirect_type
      redirect_target   = var.redirect_target
      preview           = var.preview_rule
      description       = "NodeJS attack sensitivity level 2"
      target_rule_set   = "nodejs-v33-stable"
      sensitivity_level = 2
    }

    "cve-level2" = {
      action                  = "deny(502)"
      priority                = 13
      redirect_type           = var.redirect_type
      redirect_target         = var.redirect_target
      preview                 = var.preview_rule
      description             = "CVEs sensitivity level 2"
      target_rule_set         = "cve-canary"
      sensitivity_level       = 2
      exclude_target_rule_ids = ["owasp-crs-v030001-id144228-cve"]
    }
  }

  custom_rules = var.custom_rules
}
