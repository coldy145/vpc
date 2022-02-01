resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = var.vpc_id
  cidr_block = var.secondary_cidr_block
}

resource "aws_route_table" "public_route" {
  vpc_id = var.vpc_id

  route = []

  tags = {
    Name = "Public Subnets",
    Network = "Public"
  }
}

resource "aws_route" "igw_public_route" {
  route_table_id          = aws_route_table.public_route.id 
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = var.internet_gateway
  depends_on              = [ aws_route_table.public_route ]
}
resource "aws_route" "public_route_01" {
  route_table_id          = aws_route_table.public_route.id 
  destination_cidr_block  = "10.0.0.0/8"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.public_route ]
}
resource "aws_route" "public_route_02" {
  route_table_id          = aws_route_table.public_route.id 
  destination_cidr_block  = "172.23.0.0/24"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.public_route ]
}

resource "aws_route" "public_route_03" {
  route_table_id          = aws_route_table.public_route.id 
  destination_cidr_block  = "172.23.1.0/24"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.public_route ]
}
# PrivateRouteTable01
resource "aws_route_table" "private_route_01" {
  vpc_id = var.vpc_id
  route = []
  tags = {
    Name = "Private Subnet AZ1",
    Network = "Private01"
  }
}
resource "aws_route" "nat_private_route_01" {
  route_table_id          = aws_route_table.private_route_01.id 
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = aws_nat_gateway.nat_gateway_01.id
  depends_on              = [ aws_route_table.private_route_01 ]
}
resource "aws_route" "private_route_01_01" {
  route_table_id          = aws_route_table.private_route_01.id 
  destination_cidr_block  = "10.0.0.0/8"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_01 ]
}
resource "aws_route" "private_route_01_02" {
  route_table_id          = aws_route_table.private_route_01.id 
  destination_cidr_block  = "172.23.0.0/24"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_01 ]
}

resource "aws_route" "private_route_01_03" {
  route_table_id          = aws_route_table.private_route_01.id 
  destination_cidr_block  = "172.23.1.0/24"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_01 ]
}

# PrivateRouteTable02
resource "aws_route_table" "private_route_02" {
  vpc_id = var.vpc_id
  route = []
  tags = {
    Name = "Private Subnet AZ2",
    Network = "Private02"
  }
}
resource "aws_route" "nat_private_route_02" {
  route_table_id          = aws_route_table.private_route_02.id 
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = aws_nat_gateway.nat_gateway_02.id
  depends_on              = [ aws_route_table.private_route_02 ]
}
resource "aws_route" "private_route_02_01" {
  route_table_id          = aws_route_table.private_route_02.id 
  destination_cidr_block  = "10.0.0.0/8"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_02 ]
}
resource "aws_route" "private_route_02_02" {
  route_table_id          = aws_route_table.private_route_02.id 
  destination_cidr_block  = "172.23.0.0/24"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_02 ]
}

resource "aws_route" "private_route_02_03" {
  route_table_id          = aws_route_table.private_route_02.id 
  destination_cidr_block  = "172.23.1.0/24"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_02 ]
}

# PrivateRouteTable03
resource "aws_route_table" "private_route_03" {
  vpc_id = var.vpc_id
  route = []
  tags = {
    Name = "Private Subnet AZ2",
    Network = "Private02"
  }
}
resource "aws_route" "nat_private_route_03" {
  route_table_id          = aws_route_table.private_route_03.id 
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = aws_nat_gateway.nat_gateway_03.id
  depends_on              = [ aws_route_table.private_route_03 ]
}
resource "aws_route" "private_route_03_01" {
  route_table_id          = aws_route_table.private_route_03.id 
  destination_cidr_block  = "10.0.0.0/8"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_03 ]
}
resource "aws_route" "private_route_03_02" {
  route_table_id          = aws_route_table.private_route_03.id 
  destination_cidr_block  = "172.23.0.0/24"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_03 ]
}

resource "aws_route" "private_route_03_03" {
  route_table_id          = aws_route_table.private_route_03.id 
  destination_cidr_block  = "172.23.1.0/24"
  gateway_id              = var.vpn_gateway
  depends_on              = [ aws_route_table.private_route_03 ]
}
# Subnet Public 01
resource "aws_subnet" "public_subnet_01" {
  vpc_id                          = var.vpc_id
  cidr_block                      = var.public_subnet_01
  assign_ipv6_address_on_creation = "false"
  #map_customer_owned_ip_on_launch = "false"
  map_public_ip_on_launch         = "true"
  tags = {
    Name                                        = "PublicSubnet01"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
# Subnet Public 02
resource "aws_subnet" "public_subnet_02" {
  vpc_id                          = var.vpc_id
  cidr_block                      = var.public_subnet_02
  assign_ipv6_address_on_creation = "false"
  #map_customer_owned_ip_on_launch = "false"
  map_public_ip_on_launch         = "true"
  tags = {
    Name                                        = "PublicSubnet02"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
# Subnet Public 03
resource "aws_subnet" "public_subnet_03" {
  vpc_id                          = var.vpc_id
  cidr_block                      = var.public_subnet_03
  assign_ipv6_address_on_creation = "false"
  #map_customer_owned_ip_on_launch = "false"
  map_public_ip_on_launch         = "true"
  tags = {
    Name                                        = "PublicSubnet03"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

## Subnet Private 03
resource "aws_subnet" "private_subnet_01" {
  vpc_id                          = var.vpc_id
  cidr_block                      = var.private_subnet_01
  assign_ipv6_address_on_creation = "false"
  #map_customer_owned_ip_on_launch = "false"
  map_public_ip_on_launch         = "true"
  tags = {
    Name                                        = "PrivateSubnet02"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
# Subnet Private 03
resource "aws_subnet" "private_subnet_02" {
  vpc_id                          = var.vpc_id
  cidr_block                      = var.private_subnet_02
  assign_ipv6_address_on_creation = "false"
  #map_customer_owned_ip_on_launch = "false"
  map_public_ip_on_launch         = "true"
  tags = {
    Name                                        = "PrivateSubnet02"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
# Subnet Private 03
resource "aws_subnet" "private_subnet_03" {
  vpc_id                          = var.vpc_id
  cidr_block                      = var.private_subnet_03
  assign_ipv6_address_on_creation = "false"
  #map_customer_owned_ip_on_launch = "false"
  map_public_ip_on_launch         = "true"
  tags = {
    Name                                        = "PrivateSubnet03"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

# EPI 1 
resource "aws_eip" "nat_gateway_eip1" {
  vpc                  = "true"
}
# EPI 2
resource "aws_eip" "nat_gateway_eip2" {
  vpc                  = "true"
}
# EPI 3
resource "aws_eip" "nat_gateway_eip3" {
  vpc                  = "true"
}
# NatGateway 01
resource "aws_nat_gateway" "nat_gateway_01" {
  allocation_id = aws_eip.nat_gateway_eip1.id
  subnet_id     = aws_subnet.public_subnet_01.id 

  tags = {
    Name = "NatGatewayAZ1"
  }
}
# NatGateway 02
resource "aws_nat_gateway" "nat_gateway_02" {
  allocation_id = aws_eip.nat_gateway_eip2.id
  subnet_id     = aws_subnet.public_subnet_02.id

  tags = {
    Name = "NatGatewayAZ2"
  }
}
# NatGateway 03
resource "aws_nat_gateway" "nat_gateway_03" {
  allocation_id = aws_eip.nat_gateway_eip3.id
  subnet_id     = aws_subnet.public_subnet_03.id

  tags = {
    Name = "NatGatewayAZ3"
  }
}
# Publioc Route Table Association 01
resource "aws_route_table_association" "public_rt_subnet01" {
  route_table_id = aws_route_table.public_route.id 
  subnet_id      = aws_subnet.public_subnet_01.id
}
# Publioc Route Table Association 02
resource "aws_route_table_association" "public_rt_subnet02" {
  route_table_id = aws_route_table.public_route.id 
  subnet_id      = aws_subnet.public_subnet_02.id
}
# Publioc Route Table Association 03
resource "aws_route_table_association" "public_rt_subnet03" {
  route_table_id = aws_route_table.public_route.id 
  subnet_id      = aws_subnet.public_subnet_03.id
}

# Private Route Table Association 01
resource "aws_route_table_association" "private_rt_subnet01" {
  route_table_id = aws_route_table.private_route_01.id 
  subnet_id      = aws_subnet.private_subnet_01.id
}
# Private Route Table Association 01
resource "aws_route_table_association" "private_rt_subnet02" {
  route_table_id = aws_route_table.private_route_02.id 
  subnet_id      = aws_subnet.private_subnet_02.id
}
# Private Route Table Association 01
resource "aws_route_table_association" "private_rt_subnet03" {
  route_table_id = aws_route_table.private_route_03.id 
  subnet_id      = aws_subnet.private_subnet_03.id
}

