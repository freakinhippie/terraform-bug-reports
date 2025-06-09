mock_data "vault_aws_access_credentials" {
  defaults = {
    namespace       = null
    backend         = "aws"
    role            = "somerole"
    type            = "creds"
    role_arn        = null
    region          = "us-east-1"
    ttl             = 3600
    access_key      = "AKIA....."
    secret_key      = "SECRETKEYFROMAWS"
    security_token  = null
    lease_renewable = false
  }
}