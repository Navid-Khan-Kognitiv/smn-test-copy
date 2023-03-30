module "vnet" {
  source  = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/virtual-network"
  version = "0.0.10" # Kognitiv's Terraform Module version to use

  name                = "smn-dev-vnet"
  resource_group_name = module.this.name
  location            = module.this.location # Ex: North Europe
  address_space       = ["10.15.0.0/16"]
}

module "bastion_subnet" {
  source  = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/subnet"
  version = "0.0.10"

  resource_group_name  = module.this.name
  virtual_network_name = module.vnet.name

  location_short = var.location_short

  client_name = "smn-test"
  environment = var.env

  subnet_cidr_list = ["10.15.255.0/24"]
}