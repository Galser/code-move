resource "random_pet" "demo" {
}

output "our_pet" {
 value = random_pet.demo.id
}
