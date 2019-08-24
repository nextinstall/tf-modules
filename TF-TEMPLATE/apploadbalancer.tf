resource "aws_lb" "loadbalancer" {
  name               = "${var.env_level}-${var.product}-${var.Environment}-${var.role}-lb"
  subnets            = ["${data.aws_subnet_ids.elbnets.ids}"]
  internal           = true
  load_balancer_type = "application"

  security_groups = ["${aws_security_group.lb.id}"]

  tags {
    Name        = "${var.env_level}-${var.product}-${var.Environment}-${var.role}-lb"
    Environment = "${var.Environment}"
    role        = "Load Balancer"
  }
}

resource "aws_route53_record" "record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${var.role}-${var.Environment}.${var.Environment}.adinfra.huit.harvard.edu"
  type    = "A"

  alias {
    name                   = "${aws_lb.loadbalancer.dns_name}"
    zone_id                = "${aws_lb.loadbalancer.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_lb_target_group" "http" {
  name       = "${var.env_level}-${var.product}-${var.role}-http-lb-tg"
  port       = "${var.server_http_port}"
  protocol   = "HTTP"
  stickiness = []
  vpc_id     = "${data.aws_vpc.vpc.id}"

  tags {
    Name        = "${var.env_level}-${var.product}-${var.role}-http-lb-tg"
    Environment = "${var.Environment}"
    role        = "Target Group"
  }

  stickiness {
    type = "lb_cookie"
    enabled = false
  }
  lifecycle {
   create_before_destroy = true
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.loadbalancer.arn}"
  port              = "${var.server_http_port}"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_lb_target_group.http.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "http" {
  count            = "${var.instance_count}"
  target_group_arn = "${aws_lb_target_group.http.arn}"
  target_id        = "${element(aws_instance.instance.*.id, count.index)}"
  port             = "${var.server_http_port}"
}

# ---------------------------------------------------------------------------------------------------------------------
# HTTPS Section below
# ---------------------------------------------------------------------------------------------------------------------

# resource "aws_lb_target_group" "HTTPS" {
#   name       = "${var.env_level}-${var.product}-HTTPS-lb-tg"
#   port       = "${var.server_https_port}"
#   protocol   = "HTTPS"
#   stickiness = []
#   vpc_id     = "${data.aws_vpc.vpc.id}"

#   tags {
#     Name        = "${var.env_level}-${var.product}-HTTPS-lb-tg"
#     Environment = "${var.Environment}"
#     role        = "Target Group"
#   }
#   stickiness {
#     type = "lb_cookie"
#     enabled = false
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_lb_listener" "HTTPS" {
#   load_balancer_arn = "${aws_lb.loadbalancer.arn}"
#   port              = "${var.server_https_port}"
#   protocol          = "HTTPS"
#   #ssl_policy        = "ELBSecurityPolicy-2015-05"
#   #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
#   default_action {
#     target_group_arn = "${aws_lb_target_group.HTTPS.arn}"
#     type             = "forward"
#   }
# }

# resource "aws_lb_target_group_attachment" "HTTPS" {
#   count            = "${var.instance_count}"
#   target_group_arn = "${aws_lb_target_group.HTTPS.arn}"
#   target_id        = "${element(aws_instance.instance.*.id, count.index)}"
#   port             = "${var.server_https_port}"
# }

# resource "aws_lb_target_group" "ldap" {
#   name       = "${var.env_level}-${var.product}-ldap-lb-tg"
#   port       = 389
#   protocol   = "TCP"
#   stickiness = []
#   vpc_id     = "${data.aws_vpc.vpc.id}"

#   tags {
#     Name        = "${var.env_level}-${var.product}-ldap-lb-tg"
#     Environment = "${var.Environment}"
#     role        = "Target Group"
#   }
# }

# ---------------------------------------------------------------------------------------------------------------------
# LDAP/S Section below
# ---------------------------------------------------------------------------------------------------------------------

# resource "aws_lb_target_group" "ldaps" {
#   name       = "${var.env_level}-${var.product}-ldaps-lb-tg"
#   port       = 636
#   protocol   = "TCP"
#   stickiness = []
#   vpc_id     = "${data.aws_vpc.vpc.id}"

#   tags {
#     Name        = "${var.env_level}-${var.product}-ldaps-lb-tg"
#     Environment = "${var.Environment}"
#     role        = "Target Group"
#   }
# }

# resource "aws_lb_listener" "ldap" {
#   load_balancer_arn = "${aws_lb.loadbalancer.arn}"
#   port              = "389"
#   protocol          = "TCP"

#   #ssl_policy        = "ELBSecurityPolicy-2015-05"
#   #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     target_group_arn = "${aws_lb_target_group.ldap.arn}"
#     type             = "forward"
#   }
# }

# resource "aws_lb_listener" "ldaps" {
#   load_balancer_arn = "${aws_lb.loadbalancer.arn}"
#   port              = "636"
#   protocol          = "TCP"

#   #ssl_policy        = "ELBSecurityPolicy-2015-05"
#   #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     target_group_arn = "${aws_lb_target_group.ldaps.arn}"
#     type             = "forward"
#   }
# }


# resource "aws_lb_target_group_attachment" "ldap" {
#   count            = "${var.instance_count}"
#   target_group_arn = "${aws_lb_target_group.ldap.arn}"
#   target_id        = "${element(aws_instance.instance.*.id, count.index)}"
#   port             = 389
# }

# resource "aws_lb_target_group_attachment" "ldaps" {
#   count            = "${var.instance_count}"
#   target_group_arn = "${aws_lb_target_group.ldaps.arn}"
#   target_id        = "${element(aws_instance.instance.*.id, count.index)}"
#   port             = 636
# }