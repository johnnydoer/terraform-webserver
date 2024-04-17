resource "aws_cloudfront_distribution" "webserver_cloudfront" {
  aliases         = ["webserver.aws.bajirao.dev"]
  enabled         = true
  is_ipv6_enabled = true

  origin {
    domain_name = var.ec2_alb_dns
    origin_id   = var.ec2_alb_id
    custom_origin_config {
      http_port              = 80
      origin_protocol_policy = "https-only"
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "X-Origin-Verify"
      value = "Terraform-AWS-Webserver"

    }
  }

  default_cache_behavior {
    allowed_methods          = ["GET", "HEAD"]
    cached_methods           = ["GET", "HEAD"]
    cache_policy_id          = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress                 = true
    origin_request_policy_id = aws_cloudfront_origin_request_policy.webserver_cloudfront_origin_request_policy.id
    target_origin_id         = var.ec2_alb_id
    viewer_protocol_policy   = "redirect-to-https"
  }

  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = var.cf_certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  #   web_acl_id = aws_wafv2_web_acl.arn
}

resource "aws_cloudfront_origin_request_policy" "webserver_cloudfront_origin_request_policy" {
  name = "HTTPS-ALB-Cache-Policy"
  headers_config {
    header_behavior = "whitelist"
    headers {
      items = ["Host"]
    }
  }
  cookies_config {
    cookie_behavior = "none"
  }
  query_strings_config {
    query_string_behavior = "none"
  }
}
