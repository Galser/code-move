# Terrafrom apply log

```
terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # random_pet.demo will be created
  + resource "random_pet" "demo" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + our_pet = (known after apply)
random_pet.demo: Creating...
random_pet.demo: Creation complete after 0s [id=touched-walleye]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

our_pet = "touched-walleye"
```

