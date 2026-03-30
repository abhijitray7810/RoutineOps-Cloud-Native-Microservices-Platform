module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.14.0"

  # Cluster settings
  cluster_name    = var.eksclustername
  cluster_version = "1.28"

  # VPC configuration
  vpc_id     = aws_vpc.this.id
  subnet_ids = concat(
  values(aws_subnet.public)[*].id,
  values(aws_subnet.private)[*].id
)

  # Managed Node Groups (NEW syntax)
  eks_managed_node_groups = {
    eks_nodes = {
      desired_size = var.desiredcapacity
      max_size     = var.maxsize
      min_size     = var.minsize

      instance_types = [var.instancetype]

      iam_role_arn = aws_iam_role.eks_node_role.arn
    }
  }
}