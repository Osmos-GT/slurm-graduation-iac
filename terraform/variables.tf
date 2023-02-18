variable "k8s_version" {
  type    = number
}

variable "hosts_number" {
  type    = number
}

variable "platform_id" {
  type    = string
}

variable "resources" {
    type = object({
      cores  = number
      memory = number
      disk = number
    })
    description = "K8s node VM resources variable"
}

variable "az" {
    type        = list(string)
    description = "List of yandex availability zones."
}

variable "v4_cidr_blocks" {
    type        = list(list(string))
    description = "List of CIDRs for subnets."
}

## yandex credentials ##

variable "YC_TOKEN" {
  type = string
}

variable "YC_CLOUD_ID" {
  type = string
}

variable "YC_FOLDER_ID" {
  type = string
}

## DB

variable "db_user" {
  type = string
}

variable "db_passw" {
  type = string
}

