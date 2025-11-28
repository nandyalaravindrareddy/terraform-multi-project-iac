resource "google_service_account" "sa" {
  account_id   = var.settings.account_id
  display_name = lookup(var.settings, "display_name", var.settings.account_id)
  project      = lookup(var.settings, "project_id", var.project_name)
}

output "service_account_email" {
  value = google_service_account.sa.email
}
