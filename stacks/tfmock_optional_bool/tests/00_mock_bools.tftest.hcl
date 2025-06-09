mock_provider "aws" {
  alias = "aws_mock"

  source = "./tests/mocks/aws"

  override_data {
    target = data.aws_route53_zone.main
    values = {
      arn  = "arn:aws:route53:::hostedzone/Z00014942GTRQHK3TIW6N",
      id   = "Z00014942GTRQHK3TIW6N",
      name = "example.com",
      name_servers = [
        "ns-133.awsdns-41.com",
        "ns-1374.awsdns-51.org",
        "ns-536.awsdns-17.net",
        "ns-1688.awsdns-41.co.uk"
      ],
      primary_name_server       = "ns-133.awsdns-41.com",
      private_zone              = false, # <= This attribute is `Optional: true`
      resource_record_set_count = 11,
      tags                      = {},
      vpc_id                    = null,
      zone_id                   = "Z00014942GTRQHK3TIW6N"
    }
  }
}

mock_provider "vault" {
  alias = "vault_mock"

  source = "./tests/mocks/vault"

  mock_data "vault_aws_access_credentials" {
    defaults = {
      backend         = "aws"
      role            = "somerole"
      lease_renewable = false
    }
  }
}

run "bools_are_null" {
  providers = {
    vault = vault.vault_mock
    aws   = aws.aws_mock
  }

  assert {
    condition     = aws_acmpca_certificate_authority.main.enabled != null
    error_message = <<-EOS
      Warning: aws_acmpca_certificate_authority.main.enabled should not be null:

      ${yamlencode(aws_acmpca_certificate_authority.main.enabled)}
    EOS
  }

  assert {
    condition     = data.aws_acm_certificate.main.most_recent != null
    error_message = <<-EOS
      Warning: data.aws_acm_certificate.main.most_recent should not be null:

      ${yamlencode(data.aws_acm_certificate.main.most_recent)}
    EOS
  }

  assert {
    condition     = data.aws_route53_zone.main.private_zone != null
    error_message = <<-EOS
      Warning: data.aws_route53_zone.main.private_zone should not be null:

      ${yamlencode(data.aws_route53_zone.main.private_zone)}
    EOS
  }

  assert {
    condition     = data.vault_aws_access_credentials.main.lease_renewable != null
    error_message = <<-EOS
      Warning: data.vault_aws_access_credentials.main.lease_renewable should not be null:

      ${yamlencode(data.vault_aws_access_credentials.main.lease_renewable)}
    EOS
  }

  assert {
    condition     = data.vault_azure_access_credentials.main.lease_renewable != null
    error_message = <<-EOS
      Warning: data.vault_azure_access_credentials.main.lease_renewable should not be null:

      ${yamlencode(data.vault_azure_access_credentials.main.lease_renewable)}
    EOS
  }

  assert {
    condition     = data.vault_azure_access_credentials.main.validate_creds != null
    error_message = <<-EOS
      Warning: data.vault_azure_access_credentials.main.validate_creds should not be null:

      ${yamlencode(data.vault_azure_access_credentials.main.validate_creds)}
    EOS
  }

  assert {
    condition     = data.vault_generic_secret.main.with_lease_start_time != null
    error_message = <<-EOS
      Warning: data.vault_generic_secret.main.with_lease_start_time should not be null:

      ${yamlencode(data.vault_generic_secret.main.with_lease_start_time)}
    EOS
  }
}