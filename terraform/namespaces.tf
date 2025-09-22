resource "kubernetes_namespace" "ns" {
    for_each = var.namespaces
    metadata = {
        name = each.value.name
        labels = {
            owner = "platform-team"
         }
    }
}

resource "kubernetes_resource_quota" "namespace_quota" {
    # Create a quota for each namespace that has a 'quota' block defined
    for_each = { for k, v in var.namespaces : k => v if v.quota != null }

    metadata = {
        name = "${each.key}-quota"
        namespace = kubernetes_namespace.ns[each.key].metadata[0].name
        labels = {
            owner = "platform-team"
        }
    }
    spec {
        hard = each.value.quota
     }
}