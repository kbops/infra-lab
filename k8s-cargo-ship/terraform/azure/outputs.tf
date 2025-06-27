output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}
output "aks_resource_group" {
  value = azurerm_resource_group.aks_rg.name
}
output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}
output "spot_node_pool_id" {
  value = azurerm_kubernetes_cluster_node_pool.spot_pool.id
}
output "spot_node_pool_name" {
  value = azurerm_kubernetes_cluster_node_pool.spot_pool.name
}
