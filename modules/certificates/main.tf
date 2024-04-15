data "aws_acm_certificate" "cert_webserver" {
  domain      = "*.aws.bajirao.dev"
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_acm_certificate" "cert_cloudfront" {
  provider    = aws.us-east-1
  domain      = "*.aws.bajirao.dev"
  statuses    = ["ISSUED"]
  most_recent = true
}

