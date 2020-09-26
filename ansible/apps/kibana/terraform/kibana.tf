#resource "docker_volume" "data-kibana" {
#  name = "data-kibana"
#}

resource "docker_service" "kibana" {
  name = "kibana"

  task_spec {
    container_spec {
      image = "beholder/kibana:${var.hash_commit}"
      user   = "root"

      #mounts {
          #target = "/usr/share/kibana/data"
          #source = "${docker_volume.data-kibana.name}"
          #type = "volume"
        #}

      hostname = "kibana"
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
      target_port = "5601"
      published_port = "5601"
    }
  }

  lifecycle {
      create_before_destroy = true
  }
}