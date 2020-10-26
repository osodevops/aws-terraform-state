#Makefile
.PHONY: init plan build destroy all

all: init plan build

init:
	rm -rf .terraform
	terraform init -reconfigure

plan: init
	terraform plan -refresh=true

lock:
	terraform apply -target aws_dynamodb_table.dynamodb-terraform-state-lock -lock=false -auto-approve

build:
	terraform apply -auto-approve

check: init
	terraform plan -detailed-exitcode

destroy: init
	terraform destroy -force

docs:
	terraform-docs md . > README.md

valid:
	tflint
	terraform fmt -check=true -diff=true
