# AWS EC2 Terraform module
These types of resources are supported:

* [EC2 instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
* [KEY Pair ](https://www.terraform.io/docs/providers/aws/r/key_pair.html)

# Creating SSH Key Pair:
The simplest way to generate a key pair is to run ssh-keygen without arguments. In this case, it will prompt for the file in which to store keys. Here's an example:
```bash
adecchi (12:39) ~>ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/adecchi/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/adecchi/.ssh/id_rsa.
Your public key has been saved in /home/adecchi/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:Up68jbnEV4Hgfo75YM303QdQsK3Z0aT90z0DoirrW+c adecchi@tita_gama
The key's randomart image is:
+---[RSA 2048]----+
|    .      ..oo..|
|   . . .  . .o.X.|
|    . . o.  ..+ B|
|   .   o.o  .+ ..|
|    ..o.S   o..  |
|   . %o=      .  |
|    @.B...     . |
|   o.=. o. . .  .|
|    .oo  E. . .. |
+----[SHA256]-----+
adecchi (12:40) ~>
```
It will generate the following keys:
```bash
$HOME/.ssh/id_rsa > contains your private key.
$HOME/.ssh/id_rsa.pub > contain your public key.
```

# Generate Public Key, Specifying the File Name
```bash
ssh-keygen -f ~/adecchi-pk -t rsa -b 4096
```

# Install the public key in remote server
```bash
ssh-copy-id -i $HOME/.ssh/id_rsa.pub user@instance.pepito.com.ar
```

## Usage

```hcl
module "tienda_ec2" {
  source               = "git@github.com:adecchi/terraform-aws-ec2.git?ref=tags/0.0.1"
  create_key_name             = true
  public_key                  = "ssh-rsa AAAA......"
  name                        = "tienda-ec2"
  key_name                    = "adecchi"
  amount_instances            = 1
  ami                         = "ami-0915bcb5fa77e4892"
  instance_type               = "t2.micro"
  monitoring                  = true
  vpc_security_group_ids      = [module.tienda_vpc.public_security_group_id]
  subnet_id                   = module.tienda_vpc.public_subnet_ids[0]
  associate_public_ip_address = true
  user_data                   = file("scripts/install_apache.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  depends_on = [module.tienda_vpc]
}
```

## Outputs

| Name | Description |
|------|-------------|
| ids | List of IDs of instances |
| arns | List of ARNs of instances |
| public_dns | List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC |
| public_ip | List of public IP addresses assigned to the instances, if applicable |
| private_dns | List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC |
| private_ip | List of private IP addresses assigned to the instances |
| instance_state | List of instance states of instances |
| key_name | List of key names of instances |