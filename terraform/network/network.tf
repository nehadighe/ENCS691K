### VPC ###
module "new-vpc" {
  source              = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/vpc"
  vpc-cidr            = "${lookup(var.vpc-cidr, terraform.workspace)}"
  enable-dns-support  = "${var.vpc-dns-support}"
  enable-dns-hostname = "${var.vpc-dns-hostname}"
  tags = {
    Name          = "encs_691k_vpc"
    Template      = "encs_691k"
    Purpose       = "vpc set up for encs 691 class"
    Creation_Date = "September_24_2020"
  }
}

module "vpc-flow-logs" {
  source                   = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/flow-log"
  vpc-id                   = "${module.new-vpc.vpc-id}"
  traffic-type             = "${var.traffic-type}"
  log-destination          = "${var.log-destination}"
  max-aggregation-interval = "${var.max-aggregation-interval}"
  #roles
  role-policy-name         = "${var.role-policy-name}"
  role-name                = "${var.role-name}"
  #Tags
  tags = {
    Name          = "flow-logs"
    Environment   = "${terraform.workspace}"
    Template      = "${var.template}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "October_13_2020"
  }
}

### INTERNET GATEWAY ###
module "igw-vpc" {
  source = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/igw"
  vpc-id = "${module.new-vpc.vpc-id}"
  tags = {
    Name          = "encs_691k_igw"
    Template      = "encs_691k"
    Purpose       = "vpc set up for encs 691 class"
    Creation_Date = "September_24_2020"
  }
}

### SUBNETS ###
# PUB SUBNET 1
module "public_subnet_1_a" {
  source            = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/subnet"
  vpc-id            = "${module.new-vpc.vpc-id}"
  subnet-cidr       = "${split(",", lookup(var.public-subnet-cidr-1-a, terraform.workspace))}"
  availability_zone = "us-east-1a"
  visibility        = "${var.public-type}"
  # Tags
  subnet-name         = "${split(",", lookup(var.public-subnet-name-1-a, terraform.workspace))}"
  template            = "${var.template}"
  subnet-availability = "${var.main-subnet}"
  purpose             = "${var.purpose}"
  type                = "${var.public-type}"
  created-on          = "${var.created-on}"
}
# PUB SUBNET 2
module "public_subnet_1_b" {
  source            = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/subnet"
  vpc-id            = "${module.new-vpc.vpc-id}"
  subnet-cidr       = "${split(",", lookup(var.public-subnet-cidr-1-b, terraform.workspace))}"
  availability_zone = "us-east-1b"
  visibility        = "${var.public-type}"
  # Tags
  subnet-name         = "${split(",", lookup(var.public-subnet-name-1-b, terraform.workspace))}"
  template            = "${var.template}"
  subnet-availability = "${var.main-subnet}"
  purpose             = "${var.purpose}"
  type                = "${var.public-type}"
  created-on          = "${var.created-on}"
}

# PRI SUBNET 1
module "private_subnet_1_a" {
  source            = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/subnet"
  vpc-id            = "${module.new-vpc.vpc-id}"
  subnet-cidr       = "${split(",", lookup(var.private-subnet-cidr-1-a, terraform.workspace))}"
  availability_zone = "us-east-1a"
  visibility        = "${var.private-type}"
  # Tags
  subnet-name         = "${split(",", lookup(var.private-subnet-name-1-a, terraform.workspace))}"
  template            = "${var.template}"
  subnet-availability = "${var.main-subnet}"
  purpose             = "${var.purpose}"
  type                = "${var.private-type}"
  created-on          = "${var.created-on}"
}
# PRI SUBNET 2
module "private_subnet_1_b" {
  source            = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/subnet"
  vpc-id            = "${module.new-vpc.vpc-id}"
  subnet-cidr       = "${split(",", lookup(var.private-subnet-cidr-1-b, terraform.workspace))}"
  availability_zone = "us-east-1b"
  visibility        = "${var.private-type}"
  # Tags
  subnet-name         = "${split(",", lookup(var.private-subnet-name-1-b, terraform.workspace))}"
  template            = "${var.template}"
  subnet-availability = "${var.main-subnet}"
  purpose             = "${var.purpose}"
  type                = "${var.private-type}"
  created-on          = "${var.created-on}"
}

# ### ROUTE TABLES ###
# # ROUTE TABLE: PRIVATE #
module "private-route-table" {
  source = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/rt"
  vpc-id = "${module.new-vpc.vpc-id}"
  tags = {
    Name          = "encs_691k_rt"
    Template      = "encs_691k"
    Purpose       = "route table set up for encs 691 class"
    Creation_Date = "September_24_2020"
  }
}

module "rt-pri-subnet-1" {
  source       = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/rtAssociation"
  subnet-ids   = "${module.private_subnet_1_a.subnet-id}"
  rt-id        = "${module.private-route-table.rt-id}"
  subnet-cidrs = "${split(",", lookup(var.private-subnet-cidr-1-a, terraform.workspace))}"
}

module "rt-pri-subnet-2" {
  source       = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/rtAssociation"
  subnet-ids   = "${module.private_subnet_1_b.subnet-id}"
  rt-id        = "${module.private-route-table.rt-id}"
  subnet-cidrs = "${split(",", lookup(var.private-subnet-cidr-1-b, terraform.workspace))}"
}

# # ROUTE TABLE: PUBLIC #
module "public-route-table" {
  source = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/rt"
  vpc-id = "${module.new-vpc.vpc-id}"
  tags = {
    Name          = "encs_691k_rt"
    Template      = "encs_691k"
    Purpose       = "route table set up for encs 691 class"
    Creation_Date = "September_24_2020"
  }
}

module "rt-public-subnet-1" {
  source       = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/rtAssociation"
  subnet-ids   = "${module.public_subnet_1_a.subnet-id}"
  rt-id        = "${module.public-route-table.rt-id}"
  subnet-cidrs = "${split(",", lookup(var.public-subnet-cidr-1-a, terraform.workspace))}"
}

module "rt-public-subnet-2" {
  source       = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/rtAssociation"
  subnet-ids   = "${module.public_subnet_1_b.subnet-id}"
  rt-id        = "${module.public-route-table.rt-id}"
  subnet-cidrs = "${split(",", lookup(var.public-subnet-cidr-1-b, terraform.workspace))}"
}

module "public-routes" {
  source       = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/route"
  routeTableId = "${module.public-route-table.rt-id}"
  destination  = "${var.destinationRoute}"
  igw          = "${module.igw-vpc.igw-id}"
}
