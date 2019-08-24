# Pull data from Route53 for zone
  data "aws_route53_zone" "zone" {
      name         = "${var.Environment}.adinfra.huit.harvard.edu"
      private_zone = false
    }

# Create a new load balancer
resource "aws_elb" "elb" {
  name               = "${var.env_level}-${var.product}-LDAPS-ELB"
  subnets            = ["${data.aws_subnet_ids.elbnets.ids}"]
  internal           = true
  security_groups = ["${aws_security_group.lb.id}"]
  cross_zone_load_balancing   = false
  health_check = [
    {
      target              = "SSL:${var.server_ldaps_port}"
      interval            = 10
      healthy_threshold   = 10
      unhealthy_threshold = 2
      timeout             = 5
    },
  ]
  
  access_logs {
    bucket        = "${var.elb_log_s3_bucket}"
    bucket_prefix = "${var.env_level}-${var.product}-LDAPS-ELB"
    interval      = 60
  }
  
  tags {
    Name        = "${var.env_level}-${var.product}-LDAPS-ELB"
    Environment = "${var.Environment}"
    role        = "Elastic Load Balancer"
  }
  listener {
    instance_port     = "${var.server_ldap_port}" 
    instance_protocol = "TCP"
    lb_port           = "${var.server_ldap_port}"
    lb_protocol       = "TCP"
  }

  listener {
    instance_port      = "${var.server_ldaps_port}"
    instance_protocol  = "SSL"
    lb_port            = "${var.server_ldaps_port}"
    lb_protocol        = "SSL"
    ssl_certificate_id = "${var.ssl_cert_arn}"
  }
}

resource "aws_route53_record" "record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${var.lb_dns_record}"
  type    = "A"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_elb_attachment" "attachment" {
  count            = "${var.instance_count}"
  elb              = "${aws_elb.elb.id}"
  instance         = "${element(aws_instance.instance.*.id, count.index)}"
  
}