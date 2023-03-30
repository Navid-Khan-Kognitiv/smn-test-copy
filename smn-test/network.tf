data "azurerm_nat_gateway" "natgateway" {
  name                = "smn-${var.env}-aks-node-pool-natgw"
  resource_group_name = module.this.name
}

resource "azurerm_public_ip" "pip_one" {
  name                = "smn-${var.env}-pip-1"
  location            = module.this.location
  resource_group_name = module.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "pip_two" {
  name                = "smn-${var.env}-pip-2"
  location            = module.this.location
  resource_group_name = module.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "pip_three" {
  name                = "smn-${var.env}-pip-3"
  location            = module.this.location
  resource_group_name = module.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "pip_four" {
  name                = "smn-${var.env}-pip-4"
  location            = module.this.location
  resource_group_name = module.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "pip_five" {
  name                = "smn-${var.env}-pip-5"
  location            = module.this.location
  resource_group_name = module.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "pip_six" {
  name                = "smn-${var.env}-pip-6"
  location            = module.this.location
  resource_group_name = module.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}