# terraforming-bookinfo-microservices

This repository contains a Terraform-based reimplementation of the [BookInfo microservices application](https://istio.io/latest/docs/examples/bookinfo/) originally deployed via Kubernetes YAML. Each microservice is defined as a separate Terraform module and managed in an isolated Terraform Cloud workspace.

---

## 🔧 Architecture

- **Terraform** is used to provision all Kubernetes resources instead of raw YAML.
- **Terraform Cloud** stores the state for each microservice in a dedicated workspace.
- A **Vagrant VM** runs the local Kubernetes cluster where Terraform is executed.
- Resources deployed include:
  - `Namespace`
  - `Deployments`
  - `Services`

---

## 📦 Microservice Workspaces

Each microservice is mapped to a separate Terraform Cloud workspace:

| Microservice | Workspace Name       |
|--------------|----------------------|
| ProductPage  | `productpage`        |
| Details      | `details`            |
| Reviews      | `reviews`            |
| Ratings      | `atings`             |
| Namespace    | `namespace`          |

---

## 🚀 Getting Started

### 1. Clone the Repo

```git clone https://github.com/eieiphyoaung/terraforming-bookinfo-microservices.git```
```cd terraforming-bookinfo-microservices```

### 2. Start the Vagrant Box (Local K8s Cluster)


```vagrant up```

```vagrant ssh```


**Ensure that your local Kubernetes cluster is running inside the Vagrant box.


### 3. Configure Terraform Cloud Credentials

Inside the Vagrant box, login with Terraform Cloud API token to connect local PC to Terraform Cloud:

```terraform login```


### 4. Deploy Each Microservice

Navigate to the respective microservice directory and initialize/apply:

```cd namespace/```

```terraform init```

```terraform apply -auto-approve```

Repeat this for each microservice directory: productpage/, details/, reviews/, ratings/.

 ###  📂 Directory Structure

terraforming-bookinfo-microservices/
├── namespace/
├── productpage/
├── details/
├── reviews/
├── ratings/
└── README.md

### 📘 Notes

- Be sure your .kube/config is valid inside the Vagrant environment.
- Destroy or update resources by working with the appropriate Terraform Cloud workspace.

### 🧼 Cleanup
To destroy resources from a microservice:

```terraform destroy -auto-approve```

Or destroy all workspaces from Terraform Cloud UI before deleting.






