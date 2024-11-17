provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "cra_vpc" {
  cidr_block           = "10.150.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "CRA-VPC"
  }
}

resource "aws_subnet" "cra_pub_subnet1" {
  vpc_id                  = aws_vpc.cra_vpc.id
  cidr_block              = "10.150.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "CRA-pub-subnet1"
  }
}

resource "aws_subnet" "cra_pub_subnet2" {
  vpc_id                  = aws_vpc.cra_vpc.id
  cidr_block              = "10.150.2.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "CRA-pub-subnet2"
  }
}

resource "aws_subnet" "cra_pub_subnet3" {
  vpc_id            = aws_vpc.cra_vpc.id
  cidr_block        = "10.150.3.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "CRA-pub-subnet3"
  }
}


resource "aws_subnet" "cra_pub_subnet4" {
  vpc_id            = aws_vpc.cra_vpc.id
  cidr_block        = "10.150.4.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "CRA-pub-subnet4"
  }
}


resource "aws_internet_gateway" "cra_igw" {
  vpc_id = aws_vpc.cra_vpc.id

  tags = {
    Name = "CRA-IGW"
  }
}

resource "aws_route_table" "cra_pub_rt" {
  vpc_id = aws_vpc.cra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cra_igw.id
  }

  tags = {
    Name = "CRA-PUB-RT"
  }
}

resource "aws_route_table_association" "pub_subnet1_assoc" {
  subnet_id      = aws_subnet.cra_pub_subnet1.id
  route_table_id = aws_route_table.cra_pub_rt.id
}

resource "aws_route_table_association" "pub_subnet2_assoc" {
  subnet_id      = aws_subnet.cra_pub_subnet2.id
  route_table_id = aws_route_table.cra_pub_rt.id
}

resource "aws_route_table_association" "pub_subnet3_assoc" {
  subnet_id      = aws_subnet.cra_pub_subnet3.id
  route_table_id = aws_route_table.cra_pub_rt.id
}

resource "aws_route_table_association" "pub_subnet4_assoc" {
  subnet_id      = aws_subnet.cra_pub_subnet4.id
  route_table_id = aws_route_table.cra_pub_rt.id
}

resource "aws_security_group" "cra_sg" {
  name        = "allow_cra_sg"
  description = "Allow SSH, HTTP inbound traffic"
  vpc_id      = aws_vpc.cra_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "CRA-SG"
  }
}

resource "aws_instance" "cra_Srv1" {
  ami                    = "ami-0084a47cc718c111a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.cra_pub_subnet1.id
  key_name               = "mse-svh105"
  vpc_security_group_ids = [aws_security_group.cra_sg.id]

  tags = {
    Name = "CRA-Srv1"
  }
}

resource "aws_instance" "cra_Srv2" {
  ami                    = "ami-0084a47cc718c111a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.cra_pub_subnet2.id
  key_name               = "mse-svh105"
  vpc_security_group_ids = [aws_security_group.cra_sg.id]


  tags = {
    Name = "CRA-Srv2"
  }
}

resource "aws_instance" "cra_Srv3" {
  ami                    = "ami-0084a47cc718c111a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.cra_pub_subnet3.id
  key_name               = "mse-svh105"
  vpc_security_group_ids = [aws_security_group.cra_sg.id]


  tags = {
    Name = "CRA-Srv3"
  }
}

resource "aws_instance" "cra_Srv4" {
  ami                    = "ami-0084a47cc718c111a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.cra_pub_subnet4.id
  key_name               = "mse-svh105"
  vpc_security_group_ids = [aws_security_group.cra_sg.id]


  tags = {
    Name = "CRA-Srv4"
  }
}

resource "aws_lb" "cra_lb1" {
  name            = "CRA-LB1"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.cra_sg.id]
  subnets         = [aws_subnet.cra_pub_subnet1.id, aws_subnet.cra_pub_subnet2.id]

  
  tags = {
    Name = "CRA-LB1"
  }
}

# Listener for CRA-LB1
resource "aws_lb_listener" "cra_lb1_http" {
  load_balancer_arn = aws_lb.cra_lb1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cra_lb1_tg.arn
  }
}



resource "aws_lb" "cra_lb2" {
  name               = "CRA-LB2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.cra_sg.id]
  subnets            = [aws_subnet.cra_pub_subnet3.id, aws_subnet.cra_pub_subnet4.id]

  

  tags = {
    Name = "CRA-LB2"
  }
}

# Listener for CRA-LB2
resource "aws_lb_listener" "cra_lb2_http" {
  load_balancer_arn = aws_lb.cra_lb2.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cra_lb2_tg.arn
  }
}

resource "aws_lb_target_group" "cra_lb1_tg" {
  name     = "CRA-LB1-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.cra_vpc.id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    
  }

  tags = {
    Name = "CRA-LB1-TG"
  }
}

resource "aws_lb_target_group" "cra_lb2_tg" {
  name     = "CRA-LB2-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.cra_vpc.id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    
  }

  tags = {
    Name = "CRA-LB2-TG"
  }
}



resource "aws_lb_target_group_attachment" "cra_3_attach_Srv1" {
  target_group_arn = aws_lb_target_group.cra_lb1_tg.arn
  target_id        = aws_instance.cra_Srv1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "cra_3_attach_Srv2" {
  target_group_arn = aws_lb_target_group.cra_lb1_tg.arn
  target_id        = aws_instance.cra_Srv2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "cra_3_attach_Srv3" {
  target_group_arn = aws_lb_target_group.cra_lb2_tg.arn
  target_id        = aws_instance.cra_Srv3.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "cra_3_attach_Srv4" {
  target_group_arn = aws_lb_target_group.cra_lb2_tg.arn
  target_id        = aws_instance.cra_Srv4.id
  port             = 80
}
