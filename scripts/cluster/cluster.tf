## Create a resource group to place resources
resource "azurerm_resource_group" "aks" {
  name     = "aks-shared-p"
  location = "westeurope"
  tags = {
    Department  = "Cloud Center of Exelence (CCoE)"
    Enviornment = "PROD"
    Description = "Deployed by Terraform (IaC)"
  }
}
## Create Container Registry
resource "azurerm_container_registry" "acr" {
  name                     = "sharedacr1p"
  resource_group_name      = azurerm_resource_group.aks.name
  location                 = azurerm_resource_group.aks.location
  sku                      = "Standard"
  admin_enabled            = false
  tags = {
    Enviornment = "PROD"
    Description = "Deployed by Terraform (IaC)"
  }
}
## Create the virtual network for an AKS cluster
module "network" {
  source              = "git@github.com:adminph-de/tf-fls-aks-cluster.git//modules//virtual_network?ref=cluster-v1.0"
  region              = "westeurope"
  resource_group_name = azurerm_resource_group.aks.name
  name                = "aks-shared-vnet-1-p"
  network_cidr_prefix = "10.3.36.0"
  network_cidr_suffix = 22
  subnets = [{
    name       = "aks-default-1-p"
    cidr_block = 23
    enable_service_endpoints = true
    service_endpoints_id     = ["Microsoft.Sql"]
  }]
}
## Create the AKS cluster
module "cluster" {
  source              = "git@github.com:adminph-de/tf-fls-aks-cluster.git//modules//aks_cluster?ref=cluster-v1.0"
  region              = "westeurope"
  cluster_name        = "aks-shared-1-p"
  kubernetes_version  = "1.17.11"
  resource_group_name = azurerm_resource_group.aks.name
  node_subnet_id      = module.network.subnet_ids[0] # use the subnet from the module above
  network_plugin      = "azure"
  network_policy      = "calico"
  public_ssh_key_path = "aks-key.pub"
  log_analytics_workspace_id = "/subscriptions/8e532136-bdd7-4140-84e2-b7943baf6411/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-8e532136-bdd7-4140-84e2-b7943baf6411-WEU" 
}
## Create the node pool
module "node_pool" {
  source         = "git@github.com:adminph-de/tf-fls-aks-cluster.git//modules//aks_node_pool?ref=cluster-v1.0"
  name           = "linuxakspool"
  kubernetes_version  = "1.17.11"
  aks_cluster_id = module.cluster.id
  node_subnet_id = module.network.subnet_ids[0]
}