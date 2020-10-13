## Create a resource group to place resources
resource "azurerm_resource_group" "aks" {
  name     = "aks-shared-p"
  location = "westeurope"
}
## Create the virtual network for an AKS cluster
module "network" {
  source              = "git@github.com:FairwindsOps/azure-terraform-modules.git//virtual_network?ref=virtual_network-v0.6.0"
  region              = "westeurope"
  resource_group_name = azurerm_resource_group.aks.name
  name                = "aks-shared-cluster-1-p"
  network_cidr_prefix = "10.64.0.0"
  network_cidr_suffix = 10
  subnets = [{
    name       = "aks-subnet"
    cidr_block = 16
  }]
}
## Create the AKS cluster
module "cluster" {
  source              = "git@github.com:FairwindsOps/azure-terraform-modules.git//aks_cluster?ref=aks_cluster-v0.8.0"
  region              = "westeurope"
  cluster_name        = "aks-shared-cluster-1-p"
  kubernetes_version  = "1.17.11"
  resource_group_name = azurerm_resource_group.aks.name
  node_subnet_id      = module.network.subnet_ids[0] # use the subnet from the module above
  network_plugin      = "azure"
  network_policy      = "calico"
  public_ssh_key_path = "aks-key.pub"
}
## Create the node pool
module "node_pool" {
  source         = "git@github.com:FairwindsOps/azure-terraform-modules.git//aks_node_pool?ref=aks_node_pool-v0.4.0"
  name           = "linuxakspool"
  kubernetes_version  = "1.17.11"
  aks_cluster_id = module.cluster.id
  node_subnet_id = module.network.subnet_ids[0]
}