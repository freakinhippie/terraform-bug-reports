locals {
  instances = [
    for i, v in var.instances : merge(
      v,
      {
        user_data = "# ${var.bootstrap_token}"
      }
    )
  ]
  unique_keys = { for k in toset(local.instances[*].key_name) : k => true }
}

resource "local_sensitive_file" "keys" {
  for_each = local.unique_keys

  filename        = "${path.module}/${each.key}"
  content         = each.value
  file_permission = "0600"
}