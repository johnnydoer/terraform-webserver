# Define a CloudFront distribution for the webserver
resource "aws_cloudfront_distribution" "cloudfront" {
  aliases         = ["webserver.aws.bajirao.dev"] # Alias for the CloudFront distribution
  enabled         = true                          # Enable the CloudFront distribution
  is_ipv6_enabled = true                          # Enable IPv6 support

  origin {
    domain_name = var.ec2_alb_dns # Domain name of the origin (ALB)
    origin_id   = var.ec2_alb_id  # Unique identifier for the origin
    custom_origin_config {
      http_port              = 80           # HTTP port for the origin
      origin_protocol_policy = "https-only" # Policy for the origin protocol
      https_port             = 443          # HTTPS port for the origin
      origin_ssl_protocols   = ["TLSv1.2"]  # SSL protocols for the origin
    }

    custom_header {
      name  = "X-Origin-Verify"         # Name of the custom header
      value = "Terraform-AWS-Webserver" # Value of the custom header
    }
  }

  default_cache_behavior {
    allowed_methods          = ["GET", "HEAD"]                                                          # Allowed HTTP methods
    cached_methods           = ["GET", "HEAD"]                                                          # Methods to cache
    cache_policy_id          = "658327ea-f89d-4fab-a63d-7e88639e58f6"                                   # Cache policy ID
    compress                 = true                                                                     # Enable compression
    origin_request_policy_id = aws_cloudfront_origin_request_policy.cloudfront_origin_request_policy.id # Origin request policy ID
    target_origin_id         = var.ec2_alb_id                                                           # Target origin ID
    viewer_protocol_policy   = "redirect-to-https"                                                      # Policy for viewer protocol
  }

  price_class = "PriceClass_100" # Price class for the CloudFront distribution
  restrictions {
    geo_restriction {
      restriction_type = "none" # Type of geo restriction
      locations        = []     # List of locations for geo restriction
    }
  }
  viewer_certificate {
    acm_certificate_arn      = var.cf_certificate_arn # ACM certificate ARN for the viewer certificate
    minimum_protocol_version = "TLSv1.2_2021"         # Minimum protocol version for the viewer certificate
    ssl_support_method       = "sni-only"             # SSL support method for the viewer certificate
  }

  web_acl_id = var.cloudfront_web_acl_arn # Web ACL ID for the CloudFront distribution
}

# Define an origin request policy for the CloudFront distribution
resource "aws_cloudfront_origin_request_policy" "cloudfront_origin_request_policy" {
  name = "HTTPS-ALB-Cache-Policy" # Name of the origin request policy
  headers_config {
    header_behavior = "whitelist" # Behavior for headers
    headers {
      items = ["Host"] # List of headers to whitelist
    }
  }
  cookies_config {
    cookie_behavior = "none" # Behavior for cookies
  }
  query_strings_config {
    query_string_behavior = "none" # Behavior for query strings
  }
}

# Fetch the Route 53 zone for the domain
data "aws_route53_zone" "primary" {
  name = "aws.bajirao.dev" # Name of the Route 53 zone
}

# Define a Route 53 record for the webserver
resource "aws_route53_record" "webserver" {
  zone_id = data.aws_route53_zone.primary.zone_id # Zone ID of the Route 53 zone
  name    = "webserver.aws.bajirao.dev"           # Name of the Route 53 record
  type    = "A"                                   # Type of the Route 53 record
  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name    # Alias name for the CloudFront distribution
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id # Zone ID of the CloudFront distribution
    evaluate_target_health = true                                                  # Evaluate target health
  }
}
