## Example of teh final state

```JSON
{
  "version": 4,
  "terraform_version": "1.1.7",
  "serial": 3,
  "lineage": "afa3ae4c-4017-c775-d634-cc84d6967521",
  "outputs": {
    "our_pet": {
      "value": "touched-walleye",
      "type": "string"
    }
  },
  "resources": [
    {
      "module": "module.menagerie",
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
