# Boolean attributes marked `Optional: true` are returned as `null` in mock providers

Affected Versions: `1.7.0+`

When using mock providers with `terraform test`, if a resource or data source has an attribute marked `Optional: true` then the mocked result value returned under test will be `null` unless the value is specified in the call. This is the case even if the optional attribute has a `Default: <bool>` specified in the schema. For example, consider the following simple module with tests:

_main.tf_:

```terraform
data "aws_route53_zone" "main" {
  zone_id = "Z00014942GTRQHK3TIW6N"
}
```

_tests/00_mock_bools.tftest.hcl_:

```terraform
mock_provider "aws" {
  alias = "aws_mock"

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

run "bools_are_null" {
  providers = {
    aws = aws.aws_mock
  }

  assert {
    condition     = data.aws_route53_zone.main.private_zone != null
    error_message = <<-EOS
      Warning: data.aws_route53_zone.main.private_zone should not be null:

      ${yamlencode(data.aws_route53_zone.main.private_zone)}
    EOS
  }
}
```

Testing this module results in the following error:

```sh
> terraform test
tests/00_mock_bools.tftest.hcl... in progress
  run "bools_are_null"... fail
╷
│ Error: Test assertion failed
│
│   on tests/00_mock_bools.tftest.hcl line 32, in run "bools_are_null":
│   32:     condition = data.aws_route53_zone.main.private_zone != null
│     ├────────────────
│     │ Warning: LHS and RHS values are of different types
│
│
│ Warning: data.aws_route53_zone.main.private_zone should not be null:
│
│ null
│ ...
╵
tests/00_mock_bools.tftest.hcl... tearing down
tests/00_mock_bools.tftest.hcl... fail

Failure! 0 passed, 1 failed.
```

## Quick Recreation

```sh
# clone the demo repo
git clone https://github.com/freakinhippie/terraform-bug-reports.git
# move into the repo and checkout the appropriate revision
cd terraform-bug-reports/
git checkout schema.TypeBool
# move into the stack directory to illustrate the error
cd stacks/tfmock_optional_bool/
# run terraform
terraform init
terraform test
```