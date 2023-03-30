module "vnet" {
  source  = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/virtual-network"
  version = "0.0.10" # Kognitiv's Terraform Module version to use

  name                = "${var.project_name}-vnet"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location # Ex: North Europe
  address_space       = ["10.15.0.0/16"]
}

module "bastion_subnet" {
  source  = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/subnet"
  version = "0.0.10"

  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vnet.name

  location_short = var.location_short

  client_name = "${var.project_name}-${var.env}"
  environment = var.env

  subnet_cidr_list = ["10.15.255.0/24"]
}

module "db_subnet" {
  source  = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/subnet"
  version = "0.0.10"

  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vnet.name

  location_short = var.location_short

  client_name = "${var.project_name}-${var.env}"
  environment = var.env

  subnet_cidr_list = ["10.15.254.0/24"]

  subnet_delegation = {
    "fs" = [
      {
        name    = "Microsoft.DBforMySQL/flexibleServers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    ]
  }
}