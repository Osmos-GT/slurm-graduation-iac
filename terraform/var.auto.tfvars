k8s_version = 1.23

## cluster nodes

#amount of nodes
hosts_number = 2

platform_id = "standard-v1"

resources = {
    cores = 2
    memory = 2
    disk = 40
}

az = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c"
]

## network

v4_cidr_blocks = [
    ["10.10.0.0/24"],
    ["10.11.0.0/24"],
    ["10.12.0.0/24"]
]
