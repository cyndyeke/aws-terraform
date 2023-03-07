module "all-resources" {
    source = "../module"
    db_username = local.db_username
    db_password = local.db_password
    availability_zone = var.availability_zone
}

