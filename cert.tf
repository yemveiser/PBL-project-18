# The entire section create a certiface, public zone, and validate the certificate using DNS method

# Create the certificate using a wildcard for all the domains created in yemveiser.online
resource "aws_acm_certificate" "yemveiser" {
  domain_name       = "*.yemveiser.online"
  validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "yemveiser" {
  name         = "yemveiser.online"
  private_zone = false
}

# selecting validation method
resource "aws_route53_record" "yemveiser" {
  for_each = {
    for dvo in aws_acm_certificate.yemveiser.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.yemveiser.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "yemveiser" {
  certificate_arn         = aws_acm_certificate.yemveiser.arn
  validation_record_fqdns = [for record in aws_route53_record.yemveiser : record.fqdn]
}

# create records for tooling
resource "aws_route53_record" "tooling" {
  zone_id = data.aws_route53_zone.yemveiser.zone_id
  name    = "tooling.yemveiser.online"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}


# create records for wordpress
resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.yemveiser.zone_id
  name    = "wordpress.yemveiser.online"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}
