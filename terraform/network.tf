resource "yandex_vpc_network" "this" {
  description = "Network for the Managed Service for Kubernetes cluster"
  name        = "k8s-network"
}

resource "yandex_vpc_subnet" "this" {
  for_each = toset(var.az)
  name           = "subnet-${each.value}"
  zone           = each.value
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = var.v4_cidr_blocks[index(var.az, each.value)]
}

resource "yandex_vpc_address" "this" {
  name = "LB-reserved-ip"
  external_ipv4_address {
    zone_id = var.az[0]
  }
}
