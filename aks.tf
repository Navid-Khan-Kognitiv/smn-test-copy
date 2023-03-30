module "aks" {
  source          = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/aks"
  version         = "0.0.10" # Kognitiv's Terraform Module version to use
  release_version = "1"
  subscription_id = var.subscription_id


  resource_group_name = module.resource_group.name
  vnet_name           = module.vnet.name

  aks_cluster_name          = "${var.project_name}-${var.env}-aks"
  aks_cluster_version       = "1.25.5"
  aks_cluster_acr_name      = "ccpcontainerregistry"
  acr_resource_group_name   = "shared-services"
  aks_node_pool_subnet_cidr = "10.15.0.0/24"

  k8s_docker_bridge_cidr = "172.17.0.1/16"
  k8s_service_cidr       = "10.0.0.0/16"
  k8s_dns_service_ip     = "10.0.0.10"

  system_node_pool_vm_size  = "Standard_B2s"
  system_pool_node_count    = 1
  system_node_pool_max_pods = 30

  user_node_pool_vm_size  = "Standard_B2s"
  user_pool_node_count    = 3
  user_node_pool_max_pods = 30

  enable_node_pool_host_encryption = false

  admin_group_ad_tenant_id = var.aks_ad_tenant_id
  admin_group_ad_ids       = [var.admin_group_ad_ids_1]

  global_common_tags         = local.global_common_tags
  subscription_common_tags   = local.subscription_common_tags
  environment_common_tags    = local.environment_common_tags
  resource_group_common_tags = local.resource_group_common_tags
  role_common_tags           = local.role_common_tags
}
