locals {
  ap = var.run_project != "" ? var.run_project : terraform.workspace
}

output "created_resources" {
  value = {
    iam = try(module.iam[local.ap].service_account_email, null)
    gcs = try(module.gcs[local.ap].bucket_name, null)
    bq  = try(module.bq[local.ap].dataset_id, null)
  }
}
