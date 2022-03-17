# code-move
New Terraform feature move resoutce/code

# Intro

In previous versions of Terraform ( < 1.1.7) , you had to refactor your existing infrastructure manually, by using terraform state mv to rename your resources in your project's state to match the changes to your configuration.

With the moved configuration block, you can inform Terraform about all resource address changes in your configuration. Terraform also validates those changes to provide you with clearer operational output and you can safely review plans before applying.


> this is follow-along style of the repo, it show code evolving

## Code start

We start with the following simple code :

```Terraform
resource "random_pet" "demo" {
}

output "our_pet" {
 value = random_pet.demo.id
}
```

As of result of applying we gettign the following : 

```Bash
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

E.g. we have a resource `random_pet.demo` with the value `touched-walleye`

Now, at some point we would like to make our resources into module to make thing beautiful and , well, modular : 

> modules/menagerie/main.tf

```Terraform
resource "random_pet" "demo" {
}

output "our_pet" {
 value = random_pet.demo.id
}
```

Now we need to change our main code as follow : 

```Terraform
module "menagerie" {
  source          = "./modules/menagerie"
}

output "our_pet" {
 value = module.menagerie.our_pet
}
```

Butm if now I am running `plan` it will generate following : 

```bash
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

As you can see - resrouce going to be deleted and re-created in module. But what if this is not what we want? WE can use the new syntax - `moved` block : 

```
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
```

So in a block `moved` we secifying from where to - we moving our resource, Now here is how plan adn aplpy will look : 

```bash
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

Voila!  The resource is moved, and state is updated : 

```json
{
  "version": 4,
  "terraform_version": "1.1.7",
  "serial": 2,
  "lineage": "afa3ae4c-4017-c775-d634-cc84d6967521",
  "outputs": {
    "our_pet": {
      "value": "touched-walleye",
      "type": "string"
    }
  },
  "resources": [
    {
      "mode": "managed",
      "type": "random_pet",
      "name": "demo",
      "provider": "provider[\"registry.terraform.io/hashicorp/random\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "touched-walleye",
            "keepers": null,
            "length": 2,
            "prefix": null,
            "separator": "-"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    }
  ]
}
```

This finalzie the demo. 
