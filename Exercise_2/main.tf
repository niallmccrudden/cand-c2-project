
provider "aws" {
  region = var.aws_region
  profile= "default"
}

data "archive_file" "lambda_zip" {
    type = "zip"
    source_file = "greet_lambda.py"
    output_path = "lambda.zip"
}

resource "aws_lambda_function" "udacity_greet_lambda" {
  function_name = "udacity_greet_lambda"
  filename = data.archive_file.lambda_zip.output_path
  handler = "greet_lambda.lambda_handler"
  runtime = "python3.8"
  role = aws_iam_role.lambda_execution_role.arn
  environment{
      variables = {
          greeting = "Hello World - Udacity!"
      }
  }
}

resource "aws_iam_policy_attachment" "basic_lambda_attachment" {
  name       = "basic-lambda-attachment"
  roles      = ["${aws_iam_role.lambda_execution_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "lambda_execution_role" {
   name = "serverless_example_lambda"
   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
