locals {  
  params = var.params
}
provider github {
  alias = "github1"
}
provider tfe {
  alias = "tfe1"
} 

# Add a user to the organization
resource "github_repository" "git_repo" {
  name         = local.params.git.target_repo_name
  description  = local.params.git.target_repo_name
  provider     = github.github1
# private = true
# Valid templates would be Accuont Creation, Guard
 template {
    owner      = local.params.git.bootstrap_template.owner
    repository = local.params.git.bootstrap_template.repository
  }
}


module "workspace" {
  count = length(var.params.tfe.workspaces)
  source "./mod_workspace"
  params = merge(local.params, {tfe = var.params,tfe.workspace[count.index]})
}
