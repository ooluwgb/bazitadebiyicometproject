module "gh_deployer" {
  source    = "../../modules/iam/"
  role_name = "gh_deployer_role"
}

import {
  to = module.gh_deployer.aws_iam_role.this
  id = "gh_deployer"
}
