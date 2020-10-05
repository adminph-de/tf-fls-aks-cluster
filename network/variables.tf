#VNet main settings
variable "vnet-location" {   
  description = "Location of the network"    
  default     = "westeurope"
}
variable "vnet-resource-group" { 
  description = "Resource Groupe Name"
  default     = "core-network-p"
}
variable "vnet-name" {      
  description = "VNet Name"     
  default     = "azeu1-k8s-1-vnet-p"
}
variable "vnet-address-space" {
  description = "VNet Address Space"
  default     = "10.3.38.0/22"
}
variable "vnet-dns-servers" {
  description = "Customized DNS Servers of the VNet"
  default     = ["10.31.0.132","10.31.0.192", "8.8.8.8"]
}
#Default Subnet definition
variable "default-name" {    
  description = "Default Network Name for VMs etc."    
  default     = "default-k8s__10_3_38_0_23"
}
variable "default-subnet" {   
  description = "Address scope for the default Network"  
  default     = "10.3.38.0/23"
}

#Bastion Host Settings
variable "bastion-host-name" {   
  description = "Hostname of the Bastian Host (allign with the VNet Name)"
  default     = "k8s-1-bastion-p"
}
variable "bastion-subnet" {     
  description = "Scope for the Bastion Subnet (smalles possible /26)" 
  default     = "10.3.36.64/26"
}