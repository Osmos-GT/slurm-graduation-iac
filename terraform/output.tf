output "k8s-cluster-id" {
  value = yandex_kubernetes_cluster.this.id
}

output "lb-ip" {
  value = yandex_vpc_address.this.external_ipv4_address.0.address
}

output "db-cluster-id" {
  value = yandex_mdb_postgresql_cluster.this.id
}
