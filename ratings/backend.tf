terraform {
  cloud {

    organization = "eieiphyo-ycc-org"
    hostname     = "app.terraform.io"

    workspaces {
      name    = "ratings"
      project = "bookinfo"
    }
  }
}