resource "helm_release" "grist" {
  chart           = "grist"
  repository      = "https://gitlab.com/api/v4/projects/38774220/packages/helm/stable"
  name            = var.chart_name
  namespace       = var.namespace
  version         = var.chart_version
  force_update    = var.helm_force_update
  recreate_pods   = var.helm_recreate_pods
  cleanup_on_fail = var.helm_cleanup_on_fail
  max_history     = var.helm_max_history
  timeout         = var.helm_timeout

  values = concat(
    [file("${path.module}/grist.yaml")],
    var.values
  )

  set {
    name  = "image.repository"
    value = var.image_repository
  }
  set {
    name  = "image.tag"
    value = var.image_tag
  }

  dynamic "set" {
    for_each = compact([var.limits_cpu])
    content {
      name  = "resources.limits.cpu"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.limits_memory])
    content {
      name  = "resources.limits.memory"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.requests_cpu])
    content {
      name  = "resources.requests.cpu"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.requests_memory])
    content {
      name  = "resources.requests.memory"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.backup_limits_cpu])
    content {
      name  = "backup.resources.limits.cpu"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.backup_limits_memory])
    content {
      name  = "backup.resources.limits.memory"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.backup_requests_cpu])
    content {
      name  = "backup.resources.requests.cpu"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.backup_requests_memory])
    content {
      name  = "backup.resources.requests.memory"
      value = set.value
    }
  }

  set {
    name  = "persistence.size"
    value = var.grist_persistence_size
  }

  set {
    name  = "backup.enabled"
    value = var.grist_backup_schedule != null && var.grist_backup_schedule != ""
  }
  dynamic "set" {
    for_each = compact([var.grist_backup_schedule])
    content {
      name  = "backup.schedule"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.grist_backup_s3_endpoint])
    content {
      name  = "backup.s3.endpoint"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.grist_backup_s3_region])
    content {
      name  = "backup.s3.region"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.grist_backup_s3_bucket])
    content {
      name  = "backup.s3.bucket"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = compact([var.grist_backup_s3_access_key])
    content {
      name  = "backup.s3.accessKey"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = var.grist_backup_s3_secret_key == null ? [] : [1]
    content {
      name  = "backup.s3.secretKey"
      value = var.grist_backup_s3_secret_key
    }
  }
}
