resource "aws_apprunner_auto_scaling_configuration_version" "sre-kata-apprunner-autoscaling" {
  auto_scaling_configuration_name = "sre-kata-auto-scalling"
  max_concurrency                 = 2
  max_size                        = 2
  min_size                        = 1

  tags = {
    Name    = "${var.service_name}",
    Version = "${var.service_version}"
  }
}

resource "aws_apprunner_service" "sre-kata-apprunner-service-ecr" {
  service_name = var.service_name

  source_configuration {
    image_repository {
      image_configuration {
        port = var.service_port
      }
      image_identifier      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.service_name}:latest"
      image_repository_type = "ECR"
    }
    authentication_configuration {
      access_role_arn = aws_iam_role.role.arn
    }
    auto_deployments_enabled = true
  }

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.sre-kata-apprunner-autoscaling.arn

  health_check_configuration {
    healthy_threshold   = 1
    interval            = 3
    path                = "/healthcheck"
    protocol            = "HTTP"
    timeout             = 2
    unhealthy_threshold = 5
  }

  tags = {
    Name    = "${var.service_name}",
    Version = "${var.service_version}"
  }
  depends_on = [
    aws_apprunner_auto_scaling_configuration_version.sre-kata-apprunner-autoscaling,
    aws_iam_role.role,
    aws_ecr_repository.sre-kata
  ]
}
