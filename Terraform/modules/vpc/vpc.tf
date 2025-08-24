# Get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC
resource "aws_vpc" "main" {
  region               = var.region
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      Name        = "${var.project_name}-vpc"
    },
    var.common_tags
  )
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name        = "${var.project_name}-igw"
    },
    var.common_tags
  )
}

# Public Subnets
resource "aws_subnet" "public" {
  count                  = length(var.subnet_cidrs)
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.subnet_cidrs[count.index]
  availability_zone      = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
    Name        = "${var.project_name}-public-subnet-${count.index + 1}"
    },
    var.common_tags
  )
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    {
      Name        = "${var.project_name}-public-rt"
    },
    var.common_tags
  )
}

# Route Table Association
resource "aws_route_table_association" "public" {
  count          = length(var.subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
