
resource "aws_lightsail_instance" "k3s-manager" {
  name               =  "k3s-manager"
  availability_zone  = "${var.region}a"
  blueprint_id       = "ubuntu_20_04"
  bundle_id          = "micro_2_0"
  key_pair_name      = "LightsailDefaultKeyPair"
  user_data          =  file("setup/k3s-setup-manager.sh")

}


resource "aws_lightsail_instance" "k3s-worker1" {
  name               = "k3s-worker1"
  availability_zone  = "${var.region}b"
  blueprint_id       = "ubuntu_20_04"
  bundle_id          = "micro_2_0"
  key_pair_name      = "LightsailDefaultKeyPair"
  user_data          =  file("setup/k3s-setup-worker.sh")
              
}



resource "aws_lightsail_instance" "k3s-worker2" {
  name              = "k3s-worker2"
  availability_zone = "${var.region}c"
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "micro_2_0"
  key_pair_name     = "LightsailDefaultKeyPair"
  user_data         =  file("setup/k3s-setup-worker.sh")

 
}

resource "aws_lightsail_instance" "k3s-worker3" {
  name              = "k3s-worker3"
  availability_zone = "${var.region}d"
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "micro_2_0"
  key_pair_name     = "LightsailDefaultKeyPair"
  user_data         =  file("setup/k3s-setup-worker.sh")


}

resource "aws_lightsail_instance_public_ports" "k3s-fw-rules-manager" {
  instance_name    = aws_lightsail_instance.k3s-manager.name

  port_info {
      protocol  = "tcp"
      from_port = 6443
      to_port   = 6443
      cidrs     = ["90.3.135.36/32"]

  }

  port_info {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["90.3.135.36/32"]

  }
}


resource "aws_lightsail_instance_public_ports" "k3s-fw-rules-worker1" {
  instance_name    = aws_lightsail_instance.k3s-worker1.name

  port_info {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["90.3.135.36/32"]
  }

}
 

resource "aws_lightsail_instance_public_ports" "k3s-fw-rules-worker2" {
  instance_name    = aws_lightsail_instance.k3s-worker2.name

  port_info {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["90.3.135.36/32"]
  }
}

resource "aws_lightsail_instance_public_ports" "k3s-fw-rules-worker3" {
  instance_name    = aws_lightsail_instance.k3s-worker3.name

  port_info {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["90.3.135.36/32"]
  }
}
