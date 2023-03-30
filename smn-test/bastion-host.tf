module "bastion_host" {
  source  = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/bastion-host"
  version = "0.0.10" # Kognitiv's Terraform Module version to use

  release_version = "1"

  resource_group_name = module.this.name
  location            = module.this.location

  ssh_source_address_list = ["54.232.165.254", "99.238.113.152", "112.134.140.20"]

  vnet_name = module.vnet.name
  subnet_id = module.bastion_subnet.subnet_id

  ssh_key = var.bastion_azureuser_ssh_key

  global_common_tags         = local.global_common_tags
  subscription_common_tags   = local.subscription_common_tags
  environment_common_tags    = local.environment_common_tags
  resource_group_common_tags = local.resource_group_common_tags
  role_common_tags           = local.role_common_tags
}
