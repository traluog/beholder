provider "docker" {
  host = "tcp://<IP DO DOCKER API>:2375/"
}

#ARMAZENANDO O TFSTATE NA AWS S3
terraform {
    backend "s3" {
        bucket = "repo-tfstate-terraform"
        key = "kibana.tfstate"
        region = "sa-east-1"
    }
}