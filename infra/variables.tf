variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "germanywestcentral"
}

variable "project_name" {
  description = "Project name used for tagging and naming"
  type        = string
  default     = "azure-gitops-platform"
}