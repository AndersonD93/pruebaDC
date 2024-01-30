variable "stack_id_test" {
  type        = string
  description = "Etiqueta para control de facturación"
  default     = "cdata_crm_dev"
}


locals {
    common_tags_test = {
    stack_id_test         = var.stack_id_test
  }
}


resource "aws_iam_role" "test_role_datacycle" {
  name               = "cdata_test_role"
  assume_role_policy = data.aws_iam_policy_document.test_assume_role.json
  tags               = local.common_tags_test
}


data "aws_iam_policy_document" "test_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "ec2.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucket",
      "s3:CreateBucket",
      "s3:DeleteBucket"
    ]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["iam:ReplicateTags"]
    resources = ["*"]
  }
  statement {
    effect    = "Deny"
    actions   = ["s3:GetObject"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "s3_pass_role_policy" {
  name   = "${local.common_tags_test.stack_id_test}-test-anderson"
  policy = data.aws_iam_policy_document.s3_policy.json
  tags   = local.common_tags_test
}

resource "aws_iam_role_policy_attachment" "example_attachment" {
  policy_arn = aws_iam_policy.s3_pass_role_policy.arn
  role       = aws_iam_role.test_role_datacycle.name
}