variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "addons" {
  type = map(object({
    version         = optional(string)
    resolve         = optional(string, "OVERWRITE")
    service_account = optional(string)
  }))
  default = {
    vpc-cni    = {}
    kube-proxy = {}
    coredns    = {}
  }
}
