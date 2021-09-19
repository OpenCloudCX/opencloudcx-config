terraform {
  required_providers {
    jenkins = {
      source  = "taiidani/jenkins"
      version = ">= 0.8.0"
    }
  }
}

provider "jenkins" {
  server_url = var.jenkins_url
  username   = var.jenkins_username
  password   = var.jenkins_secret
}

locals {
  jenkins_freestyle_kubectl_job = templatefile("${path.module}/projects/kubectl-test.tpl", {
    kubectl_version = var.kubectl_version
    credentialsId   = "ajnriva-github"
    }
  )
}

locals {
  jenkins_pipeline_kubectl_job = templatefile("${path.module}/projects/kubectl-test-pipeline.tpl", {
    kubectl_version = var.kubectl_version
    credentialsId   = "ajnriva-github"
    }
  )
}

resource "jenkins_job" "kubectl_test_freestyle" {
  name     = "tf-kubectl-test2"
  template = local.jenkins_freestyle_kubectl_job
}

resource "jenkins_job" "kubectl_test_pipeline" {
  name     = "tf-kubectl-pipeline-test2"
  template = local.jenkins_pipeline_kubectl_job
}

resource "jenkins_credential_username" "jenkins_github_secret" {
  name     = "ajnriva-github2"
  username = var.github_username
  password = var.github_secret
}

