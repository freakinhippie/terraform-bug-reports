data "vault_aws_access_credentials" "main" {
  backend = "aws"
  role    = "somerole"
}

data "vault_azure_access_credentials" "main" {
  backend = "aws"
  role    = "somerole"
}

data "vault_generic_secret" "main" {
  path = "secret/somerole"
}

data "aws_route53_zone" "main" {
  zone_id = "Z00014942GTRQHK3TIW6N"
  # NOTE: uncommenting the following attribute resolves the
  # mocking issue, but that does not match real-world usage
  #
  # private_zone = false
}

data "aws_acm_certificate" "main" {
  domain = "example.com"
  # most_recent = false
}

resource "aws_acmpca_certificate_authority" "main" {
  certificate_authority_configuration {
    key_algorithm     = "RSA_2048"
    signing_algorithm = "SHA256WITHRSA"
    subject {
      common_name = "example.com"
    }
  }
  tags = {}
}
