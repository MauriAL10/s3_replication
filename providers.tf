provider "aws" {
  alias  = "origin"
  region = var.origin_region
}

provider "aws" {
  alias  = "destination"
  region = var.destination_region
}
