variable "iso_url" {
  type        = string
  description = "The URL of the ISO image to use for the installation."
}

variable "iso_checksum" {
  type        = string
  description = "The checksum of the ISO image."
}

variable "output_directory" {
  type        = string
  description = "The directory where the built VM will be stored."
  default     = "./"
}

variable "http_directory" {
  type        = string
  description = "The directory to serve HTTP files from during the build."
  default     = "http"
}
