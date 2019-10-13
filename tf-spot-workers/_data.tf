
data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")

  vars = {
    cluster_name = var.cluster_name
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_iam_instance_profile" "eks_worker" {
  name = var.instance_profile_name
}

data "aws_iam_role" "fleet_role" {
  name = var.fleet_role_name
}
