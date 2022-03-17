# code-move
New Terraform feature move resoutce/code

# Intro

In previous versions of Terraform ( < 1.1.7) , you had to refactor your existing infrastructure manually, by using terraform state mv to rename your resources in your project's state to match the changes to your configuration.

With the moved configuration block, you can inform Terraform about all resource address changes in your configuration. Terraform also validates those changes to provide you with clearer operational output and you can safely review plans before applying.


