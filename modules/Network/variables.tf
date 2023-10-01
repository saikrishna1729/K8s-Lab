variable "k8slabVPC" {
  default = "10.0.0.0/16"
}

variable "k8slabPrivateSN" {
    default = "10.0.0.0/24"
  
}

variable "k8slabPublicSN" {
  default = "10.0.1.0/24"
}

variable "k8slabAZ" {
  default = "ap-southeast-1a"
}