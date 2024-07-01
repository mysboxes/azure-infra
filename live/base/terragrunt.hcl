include "root" {
  path = find_in_parent_folders()
}

dependency "shared_services" {
  config_path = "../shared-services"
}

inputs = {
  shared_services_rg        = dependency.shared_services.outputs.shared_services_rg
  shared_services_key_vault = dependency.shared_services.outputs.shared_services_key_vault
  public_dns_zone           = dependency.shared_services.outputs.public_dns_zone
}

terraform {
  source = "../../modules/1-base"
  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
    arguments = [
      "-var-file=${get_repo_root()}/conf/environments/${get_env("TG_WORKSPACE","default")}/base.tfvars.json"
    ]
  }
  before_hook "set_workspace" {
    commands = ["plan", "state", "apply", "destroy"]
    execute = ["terraform", "workspace", "select", get_env("TG_WORKSPACE", "default")]
  }
}
