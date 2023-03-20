module "host" {
  source = "../../modules/mock_ec2_instance"

  instances       = var.instances
  bootstrap_token = var.bootstrap_token
  spot_instances  = var.spot_instances
}

locals {
  unique_keys = [for k in toset(module.host.instances[*].key_name) : { "key_name" : k, "content" : "true" }]

}

/*
* Strategy 1: It seems like when Terraform leverages functions to create values from sensitive values,
* those functions tend to return the transformed values as sensitive, i.e. internally they are marked as sensitive.
* In this case, it's probably the func merge(). It also seems to occur in func keys() for map.
* This strategy uses count , basically countering the for-each evaluation,which checks if the mark sensitive on the created values.
*/
resource "local_sensitive_file" "keys" {
  count = length(local.unique_keys)

  filename        = "${path.module}/${lookup(local.unique_keys[count.index], "key_name")}"
  content         = lookup(local.unique_keys[count.index], "content")
  file_permission = "0600"
}


/*
* Strategy 2: Alternative way to achieve without modifying the original oject(i.e. containing keyname and true)
* The hack basically converts the attributes to string and then vice-versa. This is probably a bit cleaner,as it does
* uses count.
*/
locals {
  unique_spot_keys = { for k in nonsensitive(jsondecode(jsonencode(module.host.spot_instances[*]))) : k.key_name => true }
}
resource "local_sensitive_file" "spot_keys" {
  for_each = local.unique_spot_keys

  filename        = "${path.module}/${each.key}"
  content         = each.value
  file_permission = "0600"
}
