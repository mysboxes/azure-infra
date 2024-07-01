include "root" {
  path = find_in_parent_folders()
}

dependency "base" {
  config_path = "../base"
}

inputs = {
  aks_subnet_name = dependency.base.outputs.aks_subnet_name
  env_domain_name = dependency.base.outputs.env_domain_name
  env_domain_rg   = dependency.base.outputs.env_domain_rg
  vnet_name       = dependency.base.outputs.vnet_name
  vnet_rg         = dependency.base.outputs.vnet_rg
}

terraform {
  source = "../../modules/2-compute"
  before_hook "set_workspace" {
    commands = ["plan", "state", "apply", "destroy"]
    execute = ["terraform", "workspace", "select", get_env("TG_WORKSPACE", "default")]
  }
#   extra_arguments "custom_vars" {
#     commands = [
#       "apply",
#       "plan",
#       "import",
#       "push",
#       "refresh"
#     ]
#     arguments = [
#       "-var-file=${get_repo_root()}/conf/environments/${get_env("TG_WORKSPACE","default")}/compute.tfvars.json"
#     ]
#   }
}
