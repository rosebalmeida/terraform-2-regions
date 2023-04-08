resource "aws_lb" "load_balancer1" {
  name = replace("${var.project_name} lb", " ", "-")
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.instance1["loadbalance"].id]
  subnets = "${aws_subnet.subnet1.*.id}"

  tags = {
    Name = "${var.project_name} lb"
  }
}

resource "aws_lb_listener" "listener1" {
  load_balancer_arn = aws_lb.load_balancer1.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{ \"status\":\"otherwise not routed\" }"
      status_code = "200"
    }
  }
}

resource "aws_lb_target_group" "target_group1" {
  name = "${var.project_name}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "target_group1" {
  count = length(aws_instance.instance1.*.id)
  target_group_arn = aws_lb_target_group.target_group1.arn
  target_id = aws_instance.instance1[count.index].id
  port = 80
}

resource "aws_lb" "load_balancer2" {
  provider = aws.brazil
  name = replace("${var.project_name} lb", " ", "-")
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.instance2["loadbalance"].id]
  subnets = "${aws_subnet.subnet2.*.id}"

  tags = {
    Name = "${var.project_name} lb"
  }
}

resource "aws_lb_listener" "listener2" {
  provider = aws.brazil
  load_balancer_arn = aws_lb.load_balancer2.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{ \"status\":\"otherwise not routed\" }"
      status_code = "200"
    }
  }
}

resource "aws_lb_target_group" "target_group2" {
  provider = aws.brazil
  name = "${var.project_name}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc2.id
}

resource "aws_lb_target_group_attachment" "target_group1" {
  provider = aws.brazil
  count = length(aws_instance.instance2.*.id)
  target_group_arn = aws_lb_target_group.target_group1.arn
  target_id = aws_instance.instance2[count.index].id
  port = 80
}