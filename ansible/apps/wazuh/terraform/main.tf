provider "docker" {
  host = "tcp://<IP DO DOCKER API>:2375/"
}

terraform {
    backend "s3" {
        bucket = "repo-tfstate-terraform"
        key = "wazuh.tfstate"
        region = "sa-east-1"
    }
}