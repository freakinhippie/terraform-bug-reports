mock_data "vault_generic_secret" {
  defaults = {
    namespace             = null
    path                  = "secret/somerole"
    with_lease_start_time = false
  }
}