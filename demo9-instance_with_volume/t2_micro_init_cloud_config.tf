# provider "cloudinit" {
  
# }
data "template_file" "t2_micro_init_script" {
    template = "${file("scripts/init.cfg")}"

    vars{
        REGION = "${var.REGION}"
    }
}

data "template_file" "t2_micro_shell_script" {
    template = "${file("scripts/volumes.sh")}"
    vars{
        DEVICE = "${var.DEVICE_NAME}"
    }
}

data "template_cloudinit_config" "t2_micro_init_config" {
    gzip          = false
    base64_encode = false

    part {
        filename     = "init.cfg"
        content_type = "text/cloud-config"
        content      = "${data.template_file.t2_micro_init_script.rendered}"
    }

    part {
        content_type = "text/x-shellscript"
        content      = "${data.template_file.t2_micro_shell_script.rendered}"
    }
}
