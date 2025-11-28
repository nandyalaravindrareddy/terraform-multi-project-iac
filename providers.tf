provider "google" {
  # TFE workspaces should set GOOGLE_CREDENTIALS env var
  project = var.project_id
  region  = "us-central1"
}
