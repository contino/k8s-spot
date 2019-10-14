variable "cluster_name" {
  default = "caio-eks-test"
}

variable "instance_ami_id" {
  default = "ami-09f2d86f2d8c4f77d"
}

variable "instance_profile_name" {
  default = "eksctl-caio-eks-test-nodegroup-spot-instances-NodeInstanceProfile-C865U0J2XYEK"
}

variable "fleet_role_name" {
  default = "aws-ec2-spot-fleet-tagging-role"
}

variable "vpc_name" {
  default = "eksctl-caio-eks-test-cluster/VPC"
}

variable "eks_sg_name" {
  default = "eksctl-caio-eks-test-nodegroup-spot-instances/SG"
}

variable "spot_instances" {
  default = [
    {
      instance_type     = "t3.micro",
      availability_zone = "ap-southeast-2a",
      subnet_id         = "subnet-0cc51247eb7768c9b"
    },
    {
      instance_type     = "t3.micro",
      availability_zone = "ap-southeast-2b",
      subnet_id         = "subnet-0af0e3bf78fd8751b"
    }
  ]
}
