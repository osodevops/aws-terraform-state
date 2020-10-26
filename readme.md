## Creating Terraform state bucket
This guide is  setting up an AWS account for working with Terraform.

What's a state bucket?
https://www.terraform.io/docs/state/remote.html

We have chosen to use a versioned S3 state bucket.
In your terraform template repo - i.e. as in not this one, create a terraform template folder in edp-infrastructure\terrraform:
```
terraform\<application-environment>-<aws-acc-no>
```
e.g. **terraform\<<account_name>-<<account_id>>**

Inside that folder copy this template from https://github.com/osodevops/aws-terraform-state.

Update the values  **&lt;account-name&gt;** to your short account name - e.g. **aws-prod-12345678944**
and **&lt;short-tag&gt;** is **PROD** where the account is production account
and  **<role_arn>** is replaced by your role arn e.g. **arn:aws:iam::12345678944:role/Terraforming-Local-Admin**

Replace **&lt;account-name&gt;** with the account shortname in
 - aws_s3_bucket_state_bucket.tf.

Update common_tags are required.

Then when the values are all in place:
```
make init
make build
```

The state bucket is now provisioned but that state of it is not captured.
**rename the remote_state.tf.template remote_state.tf**
and rerun:
```
make init
make build
```
Opting to copy over the state as requested.

You can now delete the local **tfstate** and **tfstate.backup** files and check in the renamed remote state file.

You now have a state bucket and can run any other modules in a managed way as long as they have an similar remote_state.tf file.

Next steps:
- Run your projects through Jenkins
- Run other templates
