resource "docker_service" "praeco" {
  name = "praeco"

  task_spec {
    container_spec {
      image = "beholder/praeco:${var.hash_commit}"
      user   = "root"

      hostname = "praeco"
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
      target_port = "8080"
      published_port = "8080"
    }
  }

  lifecycle {
      create_before_destroy = true
  }
}