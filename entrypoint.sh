#!/bin/sh

set -e

export ARM_CLIENT_ID=$INPUT_ARM_CLIENT_ID
export ARM_CLIENT_SECRET=$INPUT_ARM_CLIENT_SECRET
export ARM_SUBSCRIPTION_ID=$INPUT_ARM_SUBSCRIPTION_ID
export ARM_TENANT_ID=$INPUT_ARM_TENANT_ID
export VARIABLES=$INPUT_VARIABLES
export INPUT_PATH=$INPUT_PATH

cd /github/workspace/$INPUT_PATH


var_args=""
VARIABLES=$(echo "$VARIABLES" | tr "," "\n")
for var in $VARIABLES; do
  var_args="$var_args -var $var"
done

echo "var_args:"
echo $var_args

echo "Terraform init"
terraform init -no-color

echo "Terraform plan"
terraform plan -no-color

echo "Applying Terraform templates"
terraform apply -no-color -input=false -auto-approve $var_args

echo "Destroying infrastructure"
terraform destroy -no-color -input=false -auto-approve
