helm_microservices = [
  {
    name       = "backend"
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "nginx"
    namespace  = "backend"

    values = {
      service = {
        type = "ClusterIP"
      }
    }
  },

  {
    name       = "frontend"
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "nginx"
    namespace  = "frontend"

    values = {
      service = {
        type = "LoadBalancer"
      }
    }
  }
]