mock_data "aws_route53_zone" {
  defaults = {
    arn                        = "arn:aws:route53:::hostedzone/Z00014942GTRQHK3TIW6N",
    caller_reference           = "terraform-20201229233214196300000001",
    comment                    = "example.com apex zone",
    id                         = "Z00014942GTRQHK3TIW6N",
    linked_service_description = null,
    linked_service_principal   = null,
    name                       = "example.com",
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
