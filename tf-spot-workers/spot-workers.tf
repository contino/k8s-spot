resource "aws_spot_fleet_request" "sport-workers" {
  iam_fleet_role              = data.aws_iam_role.fleet_role.arn
  target_capacity             = 1
  allocation_strategy         = "lowestPrice"
  fleet_type                  = "maintain"
  instance_pools_to_use_count = "2"

  dynamic "launch_specification" {
    for_each = var.spot_instances
    content {
      instance_type               = launch_specification.value["instance_type"]
      subnet_id                   = launch_specification.value["subnet_id"]
      availability_zone           = launch_specification.value["availability_zone"]
      associate_public_ip_address = true
      ami                         = var.instance_ami_id
      iam_instance_profile_arn    = data.aws_iam_instance_profile.eks_worker.arn
      vpc_security_group_ids      = [aws_security_group.allow_all.id]
      tags = {
        Name                                            = "${var.cluster_name}-spot-instances-Node",
        "alpha.eksctl.io/cluster-name"                  = "${var.cluster_name}",
        "alpha.eksctl.io/nodegroup-name"                = "spot-instances",
        "eksctl.cluster.k8s.io/v1alpha1/cluster-name"   = "${var.cluster_name}",
        "eksctl.io/v1alpha2/nodegroup-name"             = "spot-instances",
        "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned",
        "k8s.io/cluster-autoscaler/enabled"             = "true",
        "kubernetes.io/cluster/${var.cluster_name}"     = "owned"
      }
      user_data = base64encode(data.template_file.userdata.rendered)
    }
  }
}

resource "aws_security_group" "allow_all" {
  name        = "Allow all ingress"
  description = "Allow all ingress"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
