#EXAMPLE

# https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# create the token on the  provider platform
provider "digitalocean" {
  token = var.do_token
}

# https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster
#resource name -> K8s_init
resource "digitalocean_kubernetes_cluster" "K8s_init" { 
  name   = var.cluster_name #cluster name
  region = "nyc1"
  # conform cloud specs 
  version = "1.21.5-do.0" 
  
  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}

# https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_node_pool
resource "digitalocean_kubernetes_node_pool" "node_critical" {
  cluster_id = digitalocean_kubernetes_cluster.K8s_init.id

  name       = "critical-pool"
  size       = "s-2vcpu-2gb"
  node_count = 2

}

variable "do_token" {}
variable "cluster_name" {}

#https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster
output "kube_endpoint" {
    value= digitalocean_kubernetes_cluste.K8s_init.endpoint
}

# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
# output "kube_config" {
#     value= digitalocean_kubernetes_cluste.K8s_init.kube_config.0.raw_config
# } for sensetive data use local file
resource "local_file" "kube_config" {
    content     = digitalocean_kubernetes_cluste.K8s_init.kube_config.0.raw_config
    filename = "kube_config.yaml"
}