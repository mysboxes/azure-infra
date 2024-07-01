include "root" {
  path = find_in_parent_folders()
}

terraform {
  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
    arguments = [
      "-var-file=${get_repo_root()}/conf/common.tfvars",
      "-var-file=${get_repo_root()}/conf/shared-services.tfvars"
    ]
  }
}
