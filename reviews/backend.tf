terraform {
  cloud {

    organization = "eieiphyo-ycc-org"
    hostname     = "app.terraform.io"

    workspaces {
      name    = "reviews"
      project = "bookinfo"
    }
  }
}