provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_name
}

resource "helm_release" "microservices" {

  for_each = {
    for svc in var.helm_microservices : svc.name => svc
  }

  name  = each.value.name
  chart = each.value.chart
  repository = each.value.repository

  
  namespace        = each.value.namespace
  create_namespace = true

  values = [
    yamlencode(each.value.values)
  ]
}