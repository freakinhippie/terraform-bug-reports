mock_data "aws_acm_certificate" {
  defaults = {
    domain      = "example.com"
    most_recent = false
    tags        = {},
  }
}

override_data {
  target = data.aws_acm_certificate.main
  values = {
    most_recent = true
  }
}