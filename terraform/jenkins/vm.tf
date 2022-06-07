resource "aws_instance" "jenkins-node" {
  ami           = "ami-0756a1c858554433e"
  count = 3
  instance_type = "t3.medium"
  subnet_id = "${aws_subnet.subnet-1a.id}"
  vpc_security_group_ids = ["${aws_security_group.SG.id}"]
  key_name = "mtalkz"
 tags ={
    Environment = "${var.environment_tag}"
    Name= "jenkins-node"
  }

}

