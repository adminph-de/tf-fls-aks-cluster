variable "client_id" {}
variable "client_secret" {}

variable "agent_count" {
    default = 3
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "k8sprod"
}

variable cluster_name {
    default = "k8s-cluster-1-p"
}

variable resource_group_name {
    default = "k8s-clusters"
}

variable location {
    default = "westeurope"
}

variable log_analytics_workspace_name {
    default = "k8s-cluster-1-p"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "westeurope"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}