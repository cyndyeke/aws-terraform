

variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}



variable "region" {
  description = "region"
  type        = string
  default     = "us-east-2"
}


variable "subnet_cidr_private" {
  description = "cidr blocks for the private subnets"
  default     = ["10.20.20.0/28", "10.20.20.16/28"]
  type        = list(any)
}

variable "subnet_cidr_public" {
  description = "cidr blocks for the public subnets"
  default     = ["10.20.20.0/28", "10.20.20.16/28"]
  type        = list(any)
}

variable "availability_zone" {
  description = "availability zones for the private subnets"
  default     = ["us-east-2a", "us-east-2b"]
  type        = list(any)
}

variable "db_username" {
  description = "Database master user"
  type        = string
  sensitive   = true
}


variable "db_password" {
  description = "Database master user password"
  type        = string
  sensitive   = true
}

variable "settings" {
  description = "Configuration settings"
  type        = map(any)
  default = {
    "database" = {
      allocated_storage   = 10            
      engine              = "mysql"       
      engine_version      = "8.0.27"      
      instance_class      = "db.t2.micro" 
      db_name             = "my_db"    
      skip_final_snapshot = true
    },
    "web_app" = {
      count         = 1          
      instance_type = "t2.micro" 
    }
  }
}


variable "subnet_count" {
  description = "Number of subnets"
  type        = map(number)
  default = {
    public  = 1,
    private = 2
  }
}