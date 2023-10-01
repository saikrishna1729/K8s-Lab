# Create an EC2 instance in the private subnet
resource "aws_instance" "my_ec2_instance" {
  ami           = var.k8slabAMI  # Replace with your desired AMI ID
  instance_type = var.k8slabinstancetype
  subnet_id     = var.k8labsubnetID

  # Define user data if needed (e.g., for bootstrapping)
  user_data = <<-EOF
              #!/bin/bash
              # Your user data script goes here
              EOF

  # Define the EBS root volume with 10GB size
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }


  # Define the key pair for SSH access
  key_name = var.k8labkey  # Replace with your key pair name
}

