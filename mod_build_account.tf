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
module "create_git_repo" {
  source = "./mod_git"
  params = local.params
  providers = {
    github = github.github1
  }
}

/*
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
}*/


module "workspace" {
  count = length(local.params.tfe.workspaces)
  source = "./mod_workspace"
  providers = {
    tfe = tfe.tfe1
  }
  params = merge({git = local.params.git }, {tfe = local.params.tfe.workspaces[count.index]})
  depends_on = [module.create_git_repo]
}
