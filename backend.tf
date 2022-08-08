# Backends are responsible for storing state and providing an API for state locking. State locking is optional.
# https://www.terraform.io/language/settings/backends/configuration
# https://www.terraform.io/language/state/backends
# terraform {
#   backend "s3" {
#     region = "us-east-2"
#     bucket = "organisation-tf-state"
#     key    = "organisation.tfstate"
#   }
# }