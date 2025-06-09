mock_data "vault_azure_access_credentials" {
  defaults = {
    namespace      = null
    backend        = "aws"
    role           = "somerole"
    validate_creds = false
  }
}