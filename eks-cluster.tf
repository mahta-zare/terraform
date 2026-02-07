module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.15.1"


  name = "myapp-eks-cluster"
  kubernetes_version = "1.35"

  subnet_ids = module.myapp-vpc.private_subnets
  vpc_id = module.myapp-vpc.vpc_id

  tags = {
    environment = "development"
    application = "myapp"
  }


    self_managed_node_groups = {
    workers = {
        instance_types = ["t3.micro"]
        autoscaling_group = {
        min_size = 2
        max_size = 2
        }
    }
    }

}


