locals {  
  params = var.params
}

resource "tfe_workspace" "ws" {
  name         = local.params.tfe.tf_workspace_name
  organization = local.params.tfe.tf_org
#  provider     = tfe.tfe
   working_directory  =     local.params.tfe.git_path 
  vcs_repo {
     identifier     = "${local.params.git.target_git_org}/${local.params.git.target_repo_name}"
#     branch         = local.params.git.repo_name
     oauth_token_id =  local.params.tfe.vcs_oauth_token_id
  }
  # depends_on = [github_repository.git_repo]
}

resource "tfe_variable" "test" {
  key          = "my_key_name"
  value        = "my_value_name"
  category     = "terraform"
  workspace_id = tfe_workspace.ws.id
  description  = "a useful description"
 # provider     = tfe.tfe
}
