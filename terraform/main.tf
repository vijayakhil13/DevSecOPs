data "aws_avaiabiliy_zones" "avaiabile"{
filter{
name= "opted-in-status"
value= ["opt-on-not-required"]
}}

locals{
azs= slice(data.aws_avaiabiliy_zones.avaiabile.names,0,3)
}

module "vpc"{
source= "terraform-aws-modules/vpc/aws"
version= "~> 5.0"
name= "${var.vpc_name}-vpc"
vpc_id= "${var.vpc_id}"
cidr= var.cidr
azs= local.azs
private_subnets= [ for k, v in local.azs: cidr_block(var.vpc_cidr, 4, k)]
public_subnets= [ for k, v in local.azs: cidr_block( var.vpc_cidr, 8, k+48)]
enable_nat_gateway= true
single_nat_gateway= true
public_subnets_tags= {
"kubernets.io/role/elb"=1
}
private_subnet_tgas= {
"kubernetes.io/role/internal-elb"= 1
}}

module "eks"{
source= "terraform-aws-modules/eks/aws"
version= "~> 20.31"
cluster_name= var.cluster_name
cluster_version= var.cluster_version
cluster_compute_config= {
enables= true
node_pools= [ "general_purpose", "system" ]
}
vpc_id= module.vpc.vpc_id
subnet_ids= module.vpc.private_subnets
cluster_endpoint_public_access = true
cluster_endpoint_private_access = true
authentication_mode= "API"
cluster_encryption_config = {
resources = ["secrets" ]
}
cluster_enables_logs_types= [
"api",
"audit",
"authenticator",
"controllermanager",
"scheduler"
]
enable_cluster_creator_admin_permission= true
}




