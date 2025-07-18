data "aws_vpc" "comet_vpc" {
    id = "vpc-04f354186a7ba5b19"
}

data "aws_subnets" "comet_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.comet_vpc.id]
  }
}

data "aws_subnets" "comet_control_plane_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.comet_vpc.id]
  }

  filter {
    name   = "tag:Tier"
    values = ["control-plane"]
  }
}

