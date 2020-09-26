#resource "docker_volume" "data-elasticsearch" {
#  name = "data-elasticsearch"
#}

resource "docker_service" "elasticsearch" {
  name = "elasticsearch"

  task_spec {
    container_spec {
      image = "beholder/elasticsearch:${var.hash_commit}"
      user   = "root"

      env = {
        ES_JAVA_OPTS="-Xms512m -Xmx512m"
      }

      #mounts {
          #target = "/usr/share/elasticsearch/data"
          #source = "${docker_volume.data-elasticsearch.name}"
          #type = "volume"
        #}

      hostname = "elasticsearch"
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
      target_port = "9200"
      published_port = "9200"
    }
    ports {
      protocol = "tcp"  
      target_port = "9300"
      published_port = "9300"
    }
  }

  lifecycle {
      create_before_destroy = true
  }
}