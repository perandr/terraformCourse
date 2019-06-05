resource "aws_db_subnet_group" "db-subnet-group" {
    name="main-db-subnet"
    description = "RDS Subnet group"
    subnet_ids = ["${aws_subnet.demo12-db-private-subnet.*.id}"]
}

resource "aws_db_parameter_group" "main-db-params" {
    name="main-rds-param-group"
    family="postgres9.6"

    parameter {
        name = "max_connections"
        value = "50"
        apply_method="pending-reboot"
    }
}

resource "aws_db_instance" "main-db" {
    allocated_storage = 20
    engine="postgres"
    engine_version="10.6"
    instance_class="t3.micro"
    instance_class="db.t2.small"
    identifier="perandr-db"
    name="perandr_db"
    username="${var.DB_USER_NAME}"
    password="${var.DB_USER_PASSWORD}"
    multi_az="false"
    vpc_security_group_ids=["${aws_security_group.postgresql.id}"]
    db_subnet_group_name="${aws_db_subnet_group.postgresql-subnet-group.name}"
    storage_type="gp2"
    backup_retention_period=0
    # snapshot_identifier = "some-snap"
    skip_final_snapshot = true
    # availability_zone="${aws_subnet.demo12-db-private-subnet.*.availability_zone}"
    # availability_zone="${aws_subnet.demo12-db-private-subnet..availability_zone}"
  
}

output "DB-Instance" {
  value = "${aws_db_instance.main-db.address}"
}

