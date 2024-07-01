include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/0-shared-services"
  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
    arguments = [
      "-var-file=${get_repo_root()}/conf/shared-services.tfvars"
    ]
  }
}
