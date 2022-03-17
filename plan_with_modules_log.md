# Plan after moving resources into modules

```
terraform plan
random_pet.demo: Refreshing state... [id=touched-walleye]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # random_pet.demo will be destroyed
  # (because random_pet.demo is not in configuration)
  - resource "random_pet" "demo" {
      - id        = "touched-walleye" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.menagerie.random_pet.demo will be created
  + resource "random_pet" "demo" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

Plan: 1 to add, 0 to change, 1 to destroy.

Changes to Outputs:
  ~ our_pet = "touched-walleye" -> (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

