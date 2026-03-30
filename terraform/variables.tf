variable "awsregion" {
  default = "ap-south-1"
}

variable "vpccidr" {
  default = "10.0.0.0/16"
}

variable "publicsubnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "privatesubnets" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "eksclustername" {
  default = "routine-eks-cluster"
}

variable "nodegroupname" {
  default = "eks-node-group"
}

variable "desiredcapacity" {
  default = 2
}

variable "maxsize" {
  default = 3
}

variable "minsize" {
  default = 1
}

variable "instancetype" {
  default = "t3.medium"
}

variable "helm_microservices" {
  description = "Microservices Helm charts details"

  type = list(object({
    name      = string
    chart     = string
    namespace = string
    repository = string
    values    = map(any)
  }))

  default = [
    {
      name      = "backend"
      repository = "https://charts.bitnami.com/bitnami"
      chart     = "nginx"
      namespace = "routine-app"
      values    = {
        service = {
          type = "ClusterIP"
        }
      }
    },
    {
      name      = "frontend"
      repository = "https://charts.bitnami.com/bitnami"
      chart     = "nginx"

      namespace = "routine-app"
      values    = {
        service = {
          type = "LoadBalancer"
      }
    }
}
  ]
}