resource "aws_iam_group" "devops" {
  name = "${var.environment}-devops-group"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_group_policy_attachment" "devops_admin" {
  group      = aws_iam_group.devops.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_group" "developers" {
  name = "${var.environment}-developers-group"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_group_policy_attachment" "developers_readonly" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}


resource "aws_iam_group" "testers" {
  name = "${var.environment}-testers-group"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_group_policy_attachment" "testers_readonly" {
  group      = aws_iam_group.testers.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}



resource "aws_iam_user" "developer_user" {
  name = "developer-user"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_group_membership" "developer_membership" {
  user = aws_iam_user.developer_user.name

  groups = [
    aws_iam_group.developers.name
  ]
}

resource "aws_iam_user" "tester_user" {
  name = "tester-user"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_group_membership" "tester_membership" {
  user = aws_iam_user.tester_user.name

  groups = [
    aws_iam_group.testers.name
  ]
}

