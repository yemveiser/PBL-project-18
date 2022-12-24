region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

enable_classiclink_dns_support = "false"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

environment = "dev"

ami = "ami-0b0af3577fe5e3532"

keypair = "PBL"

master-password = "Yemmey123"

master-username = "yemmey"

# Ensure to this change to your accounbt number
account_no = "431863194908"

tags = {
  Enviroment      = "production"
  Owner-Email     = "lawaladeyemi@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "431863194908"
}
