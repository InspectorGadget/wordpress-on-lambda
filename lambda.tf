# Create AWS Lambda Function from ECR Image
resource "aws_lambda_function" "wordpress" {
  depends_on = [
    aws_ecr_repository.ecr,
    null_resource.build,
    aws_iam_role.lambda,
    aws_efs_access_point.efs,
    aws_security_group.lambda
  ]

  function_name = var.project_name
  architectures = [
    "arm64",
  ]
  package_type = "Image"
  image_uri    = "${aws_ecr_repository.ecr.repository_url}:latest"
  role         = aws_iam_role.lambda.arn
  memory_size  = 2048
  timeout      = 900

  vpc_config {
    subnet_ids = data.aws_subnets.private.ids
    security_group_ids = [
      aws_security_group.lambda.id
    ]
  }

  file_system_config {
    arn              = aws_efs_access_point.efs.arn
    local_mount_path = "/mnt/wordpress"
  }

  environment {
    variables = {
      RUST_LOG = "debug"
      PORT     = "8080"
    }
  }
}

# Update Lambda Image to latest with Lambda API
resource "null_resource" "post_deployment" {
  depends_on = [
    aws_lambda_function.wordpress,
    null_resource.build
  ]

  triggers = {
    build_number = timestamp()
  }

  provisioner "local-exec" {
    interpreter = [
      "/bin/sh",
      "-c"
    ]

    command = <<-COMMAND
        # Update Lambda Image to latest with Lambda API
        aws lambda update-function-code --function-name ${aws_lambda_function.wordpress.function_name} --image-uri ${aws_ecr_repository.ecr.repository_url}:latest
    COMMAND
  }
}

# Add API GW Lambda Permission
resource "aws_lambda_permission" "api_gateway" {
  depends_on = [
    aws_lambda_function.wordpress,
    aws_api_gateway_deployment.api
  ]

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.wordpress.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}
