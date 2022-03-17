# Plan with `moved_block`

```
 terraform plan
module.menagerie.random_pet.demo: Refreshing state... [id=touched-walleye]

Terraform will perform the following actions:

  # random_pet.demo has moved to module.menagerie.random_pet.demo
    resource "random_pet" "demo" {
        id        = "touched-walleye"
        # (2 unchanged attributes hidden)
    }

Plan: 0 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```
