resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.settings.dataset_id
  location   = lookup(var.settings, "location", "us-central1")
  project    = lookup(var.settings, "project_id", var.project_name)
}

output "dataset_id" {
  value = google_bigquery_dataset.dataset.dataset_id
}
