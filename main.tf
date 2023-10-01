module "k8slabnetwork" {
  source = "./modules/Network"
  k8slabPrivateSN = var.myLABPrivateSN
  k8slabPublicSN = var.myLABPublicSN
  k8slabVPC = var.myLABVPC
  k8slabAZ = var.myLABAZ
}