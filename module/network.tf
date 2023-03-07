resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpcCIDRblock
  enable_dns_hostnames = var.dnsHostNames
    tags = {
        Name = "my_vpc"
    }
} 


resource "aws_route" "igw-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public_rt.id
  gateway_id             = aws_internet_gateway.igw.id
}


resource "aws_route" "nat-route" {
  route_table_id         = aws_route_table.private_rt.id
  gateway_id             = aws_nat_gateway.nat.id
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "igw"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.my_eip[0].id
  subnet_id     = aws_subnet.private_subnet[0].id

  tags = {
    Name = "gw-NAT"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_subnet" "public_subnet" {
  count             = var.subnet_count.public
  
  vpc_id            = aws_vpc.my_vpc.id
  
 
  cidr_block        = var.subnet_cidr_public[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "public_subnet_${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = var.subnet_count.private 
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_private[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "private_subnet_${count.index}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_rta" {
  count          = var.subnet_count.public
  
  route_table_id = aws_route_table.public_rt.id
  
  subnet_id      = 	aws_subnet.public_subnet[count.index].id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
} 
resource "aws_route_table_association" "private_rta" {
  count          = var.subnet_count.private
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}
