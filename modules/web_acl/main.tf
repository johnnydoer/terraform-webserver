# Define a WAFv2 Web ACL for CloudFront with AWS Managed Rules
resource "aws_wafv2_web_acl" "cloudfront_web_acl" {
  provider = aws.us-east-1        # Specify the AWS provider for the us-east-1 region
  name     = "cloudfront-web-acl" # Name of the WAFv2 Web ACL
  scope    = "CLOUDFRONT"         # Scope of the WAFv2 Web ACL

  default_action {
    allow {} # Default action to allow requests
  }

  visibility_config {
    sampled_requests_enabled   = true                 # Enable sampling of requests
    cloudwatch_metrics_enabled = true                 # Enable CloudWatch metrics
    metric_name                = "cloudfront-web-acl" # Metric name for CloudWatch
  }

  # Rule to use AWS Managed Rules for Amazon IP Reputation List
  rule {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 0 # Priority of the rule

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList" # Name of the managed rule group
        vendor_name = "AWS"                                   # Vendor name of the managed rule group
      }
    }

    override_action {
      none {} # No override action
    }

    visibility_config {
      sampled_requests_enabled   = true                                        # Enable sampling of requests
      cloudwatch_metrics_enabled = true                                        # Enable CloudWatch metrics
      metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList" # Metric name for CloudWatch
    }
  }

  # Rule to use AWS Managed Rules for Common Rule Set
  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1 # Priority of the rule

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet" # Name of the managed rule group
        vendor_name = "AWS"                          # Vendor name of the managed rule group
      }
    }

    override_action {
      none {} # No override action
    }

    visibility_config {
      sampled_requests_enabled   = true                               # Enable sampling of requests
      cloudwatch_metrics_enabled = true                               # Enable CloudWatch metrics
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet" # Metric name for CloudWatch
    }
  }

  # Rule to use AWS Managed Rules for Known Bad Inputs Rule Set
  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2 # Priority of the rule

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet" # Name of the managed rule group
        vendor_name = "AWS"                                  # Vendor name of the managed rule group
      }
    }

    override_action {
      none {} # No override action
    }

    visibility_config {
      sampled_requests_enabled   = true                                       # Enable sampling of requests
      cloudwatch_metrics_enabled = true                                       # Enable CloudWatch metrics
      metric_name                = "AWS-AWSManagedRulesKnownBadInputsRuleSet" # Metric name for CloudWatch
    }
  }
}

# Define a WAFv2 Web ACL for origin verification
resource "aws_wafv2_web_acl" "origin_verify_acl" {
  name  = "OriginVerifyACL" # Name of the WAFv2 Web ACL
  scope = "REGIONAL"        # Scope of the WAFv2 Web ACL

  default_action {
    block {} # Default action to block requests
  }

  visibility_config {
    sampled_requests_enabled   = true              # Enable sampling of requests
    cloudwatch_metrics_enabled = true              # Enable CloudWatch metrics
    metric_name                = "OriginVerifyACL" # Metric name for CloudWatch
  }

  # Rule to verify the origin header
  rule {
    name     = "OriginVerifyHeaderRule"
    priority = 0 # Priority of the rule

    statement {
      byte_match_statement {
        search_string = "Terraform-AWS-Webserver" # Search string for the byte match
        field_to_match {
          single_header {
            name = "x-origin-verify" # Name of the header to match
          }
        }
        text_transformation {
          priority = 0      # Priority of the text transformation
          type     = "NONE" # Type of the text transformation
        }
        positional_constraint = "EXACTLY" # Positional constraint for the match
      }
    }

    action {
      allow {} # Action to allow requests
    }

    visibility_config {
      sampled_requests_enabled   = true                     # Enable sampling of requests
      cloudwatch_metrics_enabled = true                     # Enable CloudWatch metrics
      metric_name                = "OriginVerifyHeaderRule" # Metric name for CloudWatch
    }
  }
}
