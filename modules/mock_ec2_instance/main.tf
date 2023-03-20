# mock ec2 instance to demonstrate issue
locals {
  instances = [
    for i, v in var.instances : merge(
      v,
      {
        user_data = "# ${var.bootstrap_token}"
      }
    )
  ]
}

output "instances" {
  value = local.instances
}


# Used by Alternate strategy using jsonencode()

locals {
  spot_instances = [
    for i, v in var.spot_instances : merge(
      v,
      {
        user_data = "# ${var.bootstrap_token}"
      }
    )
  ]
}

output "spot_instances" {
  value = local.spot_instances
}
