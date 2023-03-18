module "host" {
  source = "../../modules/mock_ec2_instance"

  instances       = var.instances
  bootstrap_token = var.bootstrap_token
}

locals {
  unique_keys = { for k in toset(module.host.instances[*].key_name) : k => true }
}

resource "local_sensitive_file" "keys" {
  for_each = local.unique_keys

  filename        = "${path.module}/${each.key}"
  content         = each.value
  file_permission = "0600"
}