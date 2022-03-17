module "menagerie" {
  source          = "./modules/menagerie"
}

moved {
  from = random_pet.demo
  to = module.menagerie.random_pet.demo
}

output "our_pet" {
 value = module.menagerie.our_pet
}
