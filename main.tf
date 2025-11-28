locals {
  # active_project chosen via workspace variable run_project
  active_project = var.run_project != "" ? var.run_project : terraform.workspace

  iam_locals = jsondecode(file("${path.module}/locals/${local.active_project}/iam_locals.json"))
  gcs_locals = jsondecode(file("${path.module}/locals/${local.active_project}/gcs_locals.json"))
  bq_locals  = jsondecode(file("${path.module}/locals/${local.active_project}/bq_locals.json"))

  enabled_iam = try(local.iam_locals.enabled, false) ? { (local.active_project) = local.iam_locals } : {}
  enabled_gcs = try(local.gcs_locals.enabled, false) ? { (local.active_project) = local.gcs_locals } : {}
  enabled_bq  = try(local.bq_locals.enabled, false)  ? { (local.active_project) = local.bq_locals } : {}
}

module "iam" {
  for_each = local.enabled_iam
  source   = "./modules/iam"

  settings     = each.value
  project_name = each.key
}

module "gcs" {
  for_each = local.enabled_gcs
  source   = "./modules/gcs"

  settings     = each.value
  project_name = each.key
}

module "bq" {
  for_each = local.enabled_bq
  source   = "./modules/bq"

  settings     = each.value
  project_name = each.key
}
