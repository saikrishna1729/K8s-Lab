module "k8slabnetwork" {
  source = "./modules/Network"
  k8slabPrivateSN = var.myLABPrivateSN
  k8slabPublicSN = var.myLABPublicSN
  k8slabVPC = var.myLABVPC
  k8slabAZ = var.myLABAZ
}


module "k8labcompute-masternode" {
  source = "./modules/Compute"
  k8labkey = var.mylabkey
  k8labsubnetID = local.labprivatesubnet
}

locals {
  labprivatesubnet = module.k8slabnetwork.subnetid
}