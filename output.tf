output "omikuji_url" {
  value = "http://${module.api.alb_dns_name}/omikuji"
}
