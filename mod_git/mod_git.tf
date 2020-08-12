locals {
  params = var.params
}

# Add a user to the organization
resource "github_repository" "git_repo" {
  name         = local.params.git.target_repo_name
  description  = local.params.git.target_repo_name
#  provider     = github.github1
# private = true
# Valid templates would be Accuont Creation, Guard 
 template {
    owner      = local.params.git.bootstrap_template.owner
    repository = local.params.git.bootstrap_template.repository
  }
}
