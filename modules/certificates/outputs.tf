output "certificate_arn" {
  description = "The ARN of the ACM Certificate"
  value       = data.aws_acm_certificate.cert_webserver.arn
}