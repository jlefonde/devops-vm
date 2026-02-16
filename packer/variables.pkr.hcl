variable "iso_url" {
  type        = string
  description = "The URL of the ISO image to use for the installation."
}

variable "iso_checksum" {
  type        = string
  description = "The checksum of the ISO image."
}

variable "output_dir" {
  type        = string
  description = "The directory where the built VM will be stored."
  default     = "output"
}

variable "http_dir" {
  type        = string
  description = "The directory to serve HTTP files from during the build."
  default     = "http"
}

variable "hcp_client_id" {
  type        = string
  description = "HCP client ID for authentication with HashiCorp Cloud Platform."
  default     = "${env("HCP_CLIENT_ID")}"
}

variable "hcp_client_secret" {
  type        = string
  description = "HCP client secret for authentication with HashiCorp Cloud Platform."
  default     = "${env("HCP_CLIENT_SECRET")}"
}

variable "organization" {
  type        = string
  description = "The organization name for the Vagrant box."
}

variable "box_name" {
  type        = string
  description = "The name of the Vagrant box."
}

variable "box_version" {
  type    = string
  description = "The version of the box to publish."
}

variable "box_architecture" {
  type        = string
  description = "The architecture of the box (e.g., amd64, arm64)."
}
