resource "aws_iam_role" "this" {
  name                  = "${local.stack}-cloudwatch-metric-stream-role"
  description           = "Role assumed by the CloudWatch Metric Stream services"
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  force_detach_policies = var.force_detach_policies
}

resource "aws_iam_policy" "this" {
  name        = "default"
  description = "Allows delivery to Kinesis Firehose Delivery Stream"
  policy      = data.aws_iam_policy_document.this.json
}

resource "aws_iam_group_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
