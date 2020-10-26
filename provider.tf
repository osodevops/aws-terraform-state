provider "aws" {
  region  = "<<region>>"

  assume_role {
    role_arn     = "arn:aws:iam::<<account_id>>:role/Terraforming-Local-Admin"
    session_name = "Terraforming"
  }
}
