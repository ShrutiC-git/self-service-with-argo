# Creating RBAC for our namespaces

resource "kubernetes_service_account" "namespace_sa" {
    for_each = { for k, v in var.namespaces : k => v if v.rbac != null }
    metadata {
        name = each.value.rbac.service_account_name
        namespace = kubernetes_namespace.ns[each.key].metadata[0].name
    }
}

resource "kubernetes_role" "namespace_role" {
    for_each = { for k, v in var.namespaces : k => v if v.rbac !=null}

    metadata {
        name = each.value.rbac.role_name
        namespace = kubernetes_namespace.ns[each.key].metadata[0].name
    }

    dynamic "rule" {
        for_each = each.value.rbac.rules
        content {
            api_groups = rule.value.api_groups
            resources = rule.value.resources
            verbs = rule.value.verbs
        }
    }
}

resource "kubernetes_role_binding" "namespace_role_binding" {
    for_each = { for k, v in var.namespaces : k => v if v.rbac != null }
    metadata {
        name = "${each.value.rbac.role_name}-binding" # Use role name for binding name
        namespace = kubernetes_namespace.ns[each.key].metadata[0].name
    }

    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind = "Role"
        name = kubernetes_role.namespace_role[each.key].metadata[0].name
    }

    subject {
        kind = "ServiceAccount"
        name = kubernetes_service_account.namespace_sa[each.key].metadata[0].name
        namespace = kubernetes_namespace.ns[each.key].metadata[0].name
    }
}