resource "aws_lightsail_static_ip" "k3s-manager-ip" {
  name      = "k3s-manager-ip"
  depends_on = [    aws_lightsail_instance.k3s-manager  ]
}
resource "aws_lightsail_static_ip_attachment" "manager" {
   static_ip_name = "${aws_lightsail_static_ip.k3s-manager-ip.name}"
   instance_name  = "${aws_lightsail_instance.k3s-manager.name}"
   depends_on     = [    aws_lightsail_instance.k3s-manager  ]

}
resource "aws_lightsail_instance" "k3s-manager" {
  name               =  "k3s-manager"
  availability_zone  = "${var.region}a"
  blueprint_id       = "ubuntu_20_04"
  bundle_id          = "micro_2_0"
  key_pair_name      = "LightsailDefaultKeyPair"
  user_data          = file("setup/k3s-setup-manager.sh")


}

 
 resource "aws_lightsail_instance" "k3s-worker" {
  count              = var.instance_count
  availability_zone  = "${element(split(",", var.availability_zones), count.index)}"
  blueprint_id       = "ubuntu_20_04"
  name               = "k3s_worker${count.index + 1}"
  bundle_id          = "micro_2_0"
  key_pair_name      = "LightsailDefaultKeyPair"
  user_data          =  file("setup/k3s-setup-worker.sh")


}

resource "aws_lightsail_instance_public_ports" "k3s-fw-rules-manager" {
  instance_name    = aws_lightsail_instance.k3s-manager.name

  port_info {
      protocol  = "tcp"
      from_port = 6443
      to_port   = 6443
      cidrs     = ["90.3.135.36/32", "${aws_lightsail_instance.k3s-worker[0].public_ip_address}/32", "${aws_lightsail_instance.k3s-worker[1].public_ip_address}/32",  "${aws_lightsail_instance.k3s-worker[2].public_ip_address}/32" ]

  }

  port_info {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["90.3.135.36/32"]

  }

   port_info {
      protocol  = "tcp"
      from_port = 80
      to_port   = 80

  }

 port_info {
      protocol  = "tcp"
      from_port = 443
      to_port   = 443

  }

   port_info {
      protocol  = "tcp"
      from_port = 8001
      to_port   = 8001
      cidrs     = ["90.3.135.36/32"]

  }
}


resource "aws_lightsail_instance_public_ports" "k3s-fw-rules-worker1" {
  instance_name    = aws_lightsail_instance.k3s-worker[0].name

  port_info {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["90.3.135.36/32"]
  }
}


resource "aws_lightsail_instance_public_ports" "k3s-fw-rules-worker2" {
  instance_name    = aws_lightsail_instance.k3s-worker[1].name

  port_info {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["90.3.135.36/32"]
  }
}

resource "aws_lightsail_instance_public_ports" "k3s-fw-rules-worker3" {
  instance_name    = aws_lightsail_instance.k3s-worker[2].name

  port_info {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["90.3.135.36/32"]
  }
}

