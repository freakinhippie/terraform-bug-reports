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
