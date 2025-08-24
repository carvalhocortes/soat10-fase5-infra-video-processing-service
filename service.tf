resource "kubernetes_service" "app_lb" {
  metadata {
    name      = "eks-fiap-soat10"
    namespace = "default"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
    }
  }

  spec {
    selector = {
      app = "video-processing-app"
    }
    port {
      port        = 80
      target_port = 3333
    }
    type = "LoadBalancer"
  }
}
