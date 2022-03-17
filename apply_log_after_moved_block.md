## Example of apply after using `moved_block`

```
terraform apply --auto-approve
module.menagerie.random_pet.demo: Refreshing state... [id=touched-walleye]

Terraform will perform the following actions:

  # random_pet.demo has moved to module.menagerie.random_pet.demo
    resource "random_pet" "demo" {
        id        = "touched-walleye"
        # (2 unchanged attributes hidden)
    }

Plan: 0 to add, 0 to change, 0 to destroy.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

our_pet = "touched-walleye"
```
