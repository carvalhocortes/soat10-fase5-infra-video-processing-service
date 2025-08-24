resource "aws_ecr_repository" "repositorio" {
  for_each = toset(var.REPOSITORY-NAMES)
  name     = each.value

  force_delete = true
}
