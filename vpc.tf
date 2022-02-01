module "vpc_subnet" {
    source                  = "./modules/vpc"
    vpc_id                  = var.vpc_id
    secondary_cidr_block    = var.secondary_cidr_block
    internet_gateway        = var.internet_gateway
    vpn_gateway             = var.vpn_gateway
    public_subnet_01        = var.public_subnet_01
    public_subnet_02        = var.public_subnet_02
    public_subnet_03        = var.public_subnet_03
    private_subnet_01       = var.private_subnet_01
    private_subnet_02       = var.private_subnet_02
    private_subnet_03       = var.private_subnet_03
    cluster_name            = var.cluster_name
}
