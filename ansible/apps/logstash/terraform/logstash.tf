#resource "docker_volume" "data-logstash" {
  #name = "data-logstash"
#}

#resource "docker_volume" "pipeline-logstash" {
  #name = "pipeline-logstash"
#}

resource "docker_service" "logstash" {
  name = "logstash"

  task_spec {
    container_spec {
      image = "beholder/logstash:${var.hash_commit}"
      user   = "root"

      #mounts {
          #target = "/usr/share/logstash/data"
          #source = "${docker_volume.data-logstash.name}"
          #type = "volume"
        #}

      #mounts {
          #target = "/usr/share/logstash/pipeline"
          #source = "${docker_volume.pipeline-logstash.name}"
          #type = "volume"
        #}

      hostname = "logstash"
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
      target_port = "5044"
      published_port = "5044"
    }
  }

  lifecycle {
      create_before_destroy = true
  }
}