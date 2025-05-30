terraform {
  cloud {

    organization = "eieiphyo-ycc-org"
    hostname     = "app.terraform.io"

    workspaces {
      name    = "details"
      project = "bookinfo"
    }
  }
}