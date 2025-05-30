terraform {
  cloud {

    organization = "eieiphyo-ycc-org"
    hostname     = "app.terraform.io"

    workspaces {
      name    = "productpage"
      project = "bookinfo"
    }
  }
}