# Infrastructure for Yandex Cloud Managed Service for Kubernetes cluster with Calico network policy management.

resource "yandex_kubernetes_cluster" "this" {
  description = "Managed Service for Kubernetes cluster"
  name        = "k8s-cluster"
  network_id  = yandex_vpc_network.this.id

  master {
    version = var.k8s_version
    zonal {
      zone      = var.az[0]
      subnet_id = yandex_vpc_subnet.this["ru-central1-a"].id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = false
    }

  }
  service_account_id      = yandex_iam_service_account.this.id
  node_service_account_id = yandex_iam_service_account.this.id
  network_policy_provider = "CALICO"
  depends_on = [
    yandex_vpc_address.this,
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}

resource "yandex_kubernetes_node_group" "this" {
  description = "Node group for the Managed Service for Kubernetes cluster"
  name        = "k8s-node-group"
  cluster_id  = yandex_kubernetes_cluster.this.id
  version     = var.k8s_version

  scale_policy {
    fixed_scale {
      size = var.hosts_number
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
    location {
      zone = "ru-central1-b"
    }
    location {
      zone = "ru-central1-c"
    }
  }
  
    instance_template {
    platform_id = var.platform_id

    network_interface {
      nat                = true
      subnet_ids         = values(yandex_vpc_subnet.this)[*].id
    }

    resources {
      memory = var.resources.memory
      cores  = var.resources.cores
    }

    boot_disk {
      type = "network-hdd"
      size = var.resources.disk
    }
    
    # Add your ssh public key in case you want to connect to the node via ssh for debug.
    # The key have to be specified in the special format https://cloud.yandex.ru/docs/managed-kubernetes/operations/node-connect-ssh
    # metadata = {
    #   ssh-keys:"osmos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFE6BeJjX7DQtNnIFmsJKfqtLf/RqNy7rzbjx2UWvwjL osmos"
    # }
  }
}