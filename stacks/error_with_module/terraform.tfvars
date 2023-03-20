bootstrap_token = "supersecret"
instances = [
  {
    name     = "my-ec2-instance-0"
    key_name = "my-ec2-key-0"
  },
  {
    name     = "my-ec2-instance-1"
    key_name = "my-ec2-key-1"
  }
]

spot_instances = [
  {
    name     = "my-ec2-spot-instance-0"
    key_name = "my-ec2-spot-key-0"
  },
  {
    name     = "my-ec2-spot-instance-1"
    key_name = "my-ec2-spot-key-1"
  }
]