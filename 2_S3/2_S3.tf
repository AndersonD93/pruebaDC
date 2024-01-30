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

resource "aws_s3_bucket" "s3_bucket_anderson_test" {
  bucket = "cdata-crm-s3-anderson-test"
  acl    = "private"
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    enabled = true
    expiration {
      days = 15
    }
  }
  tags = merge(
    local.common_tags_test,
    {
      "Name" = "${var.stack_id_test}-s3-glue-anderson"
    },
  )
}