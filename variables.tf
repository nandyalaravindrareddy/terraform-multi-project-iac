variable "run_project" {
  description = "Project identifier set in TFE workspace variables (e.g., project1)."
  type        = string
  default     = ""
}

variable "project_id" {
  description = "GCP project id (overrides default)."
  type        = string
  default     = "custom-plating-475002-j7"
}
