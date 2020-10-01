resource "docker_service" "wazuh" {
  name = "wazuh"

  task_spec {
    container_spec {
      image = "beholder/wazuh:${var.hash_commit}"
      user   = "root"

      hostname = "wazuh"
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
      target_port = "1514"
      published_port = "1514"
    }
    ports {
      protocol = "tcp"  
      target_port = "1515"
      published_port = "1515"
    }
    ports {
      protocol = "tcp"  
      target_port = "55000"
      published_port = "55000"
    }
  }

  lifecycle {
      create_before_destroy = true
  }
}