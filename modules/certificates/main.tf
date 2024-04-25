# Fetch the most recent ACM certificate for the specified domain in the default AWS provider
data "aws_acm_certificate" "cert_webserver" {
  domain      = "*.aws.bajirao.dev" # Domain name for which the certificate is issued
  statuses    = ["ISSUED"]          # Filter certificates by their status
  most_recent = true                # Ensure the most recently issued certificate is fetched
}

# Fetch the most recent ACM certificate for the specified domain in the AWS provider for the us-east-1 region
data "aws_acm_certificate" "cert_cloudfront" {
  provider    = aws.us-east-1       # Specify the AWS provider for the us-east-1 region
  domain      = "*.aws.bajirao.dev" # Domain name for which the certificate is issued
  statuses    = ["ISSUED"]          # Filter certificates by their status
  most_recent = true                # Ensure the most recently issued certificate is fetched
}


# TODO: Write code to create certificates if not already existing and output the NameServers for the domain.