resource "google_storage_bucket" "bucket" {
  name     = var.settings.bucket_name
  location = lookup(var.settings, "location", "US")
  project  = lookup(var.settings, "project_id", var.project_name)
}

output "bucket_name" {
  value = google_storage_bucket.bucket.name
}
