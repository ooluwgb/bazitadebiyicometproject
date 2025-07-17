locals {
  coredns_addon_config_vals = {
    tolerations = [{
      key      = "pool"
      operator = "Equal"
      value    = "static"
      effect   = "NoSchedule"
    }]
    affinity = {
      nodeAffinity = {
        requiredDuringSchedulingIgnoredDuringExecution = {
          nodeSelectorTerms = [
            {
              matchExpressions = [{
                key      = "eks.amazonaws.com/capacityType"
                operator = "In"
                values   = ["ON_DEMAND"]
              }]
            },
            {
              matchExpressions = [{
                key      = "karpenter.sh/capacity-type",
                operator = "In"
                values   = ["on-demand"]
              }]
            }
          ]
        }
      }
    }
    podLabels = {
      "moneylion.com/eks-addons" = "coredns"
    }
    podDisruptionBudget = {
      enabled        = true
      maxUnavailable = 1
    }
    topologySpreadConstraints = [
      {
        maxSkew           = 1
        topologyKey       = "kubernetes.io/hostname"
        whenUnsatisfiable = "ScheduleAnyway"
        labelSelector = {
          matchLabels = {
            "moneylion.com/eks-addons" = "coredns"
          }
        }
      },
      {
        maxSkew           = 1
        topologyKey       = "topology.kubernetes.io/zone"
        whenUnsatisfiable = "ScheduleAnyway"
        labelSelector = {
          matchLabels = {
            "moneylion.com/eks-addons" = "coredns"
          }
        }
    }]
    autoScaling = {
      enabled     = true
      minReplicas = 2
      maxReplicas = 5
    }
  }
}