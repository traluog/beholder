resource "docker_service" "elastalert" {
  name = "elastalert"

  task_spec {
    container_spec {
      image = "beholder/elastalert:${var.hash_commit}"
      user   = "node"

      env = {
        PRAECO_ELASTICSEARCH="elasticsearch"
      }

      hostname = "elastalert"
    }

    restart_policy = {
      condition    = "on-failure"
      delay        = "5s"
    }

    networks = ["beholder"]
  }

  mode {
    replicated {
      replicas = 1
    }
  }

  endpoint_spec {
    ports {
      protocol = "tcp"  
      target_port = "3030"
      published_port = "3030"
    }
    ports {
      protocol = "tcp"  
      target_port = "3333"
      published_port = "3333"
    }
  }

  lifecycle {
      create_before_destroy = true
  }
}