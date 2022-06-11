resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.cfg",
    {
      public_ip        = aws_instance.main.public_ip
      private_key_path = pathexpand(var.PRIVATE_KEY_PATH)
      user             = lookup(local.users, var.AMI_NAME, "ec2-user")
    }
  )
  filename = "../ansible/inventory/aws/hosts"
}

resource "local_file" "context" {
  content = templatefile("templates/environment.sh",
    {
      public_ip        = aws_instance.main.public_ip
      private_key_path = pathexpand(var.PRIVATE_KEY_PATH)
      user             = lookup(local.users, var.AMI_NAME, "ec2-user")
    }
  )
  filename = "../aws.env"
}

