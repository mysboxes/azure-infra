remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "azure-infra"
    storage_account_name = "azureinfra2185"
    container_name       = "tfstate"
    key                  = format("%s.tfstate", get_path_from_repo_root())
  }
}
