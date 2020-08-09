locals {
  
  params = var.params

}

# Add a user to the organization
resource "github_repository" "git_repo" {
  name         = local.params.git.repo_name
  description  = local.params.git.repo_name
  provider     = github.github1
# private = true
# Valid templates would be Accuont Creation, Guard
 template {
    owner      = local.params.git.bootstrap_template.owner
    repository = local.params.git.bootstrap_template.repository
  }
}

resource "tfe_workspace" "test" {
  name         = local.params.tfe.tf_workspace_name
  organization = local.params.tfe.tf_org
  provider     = tfe.tfe1
  vcs_repo {
     identifier     = "${local.params.git.git_org}/${local.params.git.repo_name}"
#     branch         = local.params.git.repo_name
     oauth_token_id =  local.params.git.vcs_oauth_token_id
  }
}

resource "tfe_variable" "test" {
  key          = "my_key_name"
  value        = "my_value_name"
  category     = "terraform"
  workspace_id = tfe_workspace.test.id
  description  = "a useful description"
  provider     = tfe.tfe1
}
