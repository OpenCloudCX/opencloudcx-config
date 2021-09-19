#!/bin/bash

##### Add jenkins jobx
# terraform init
# terraform apply -var "jenkins_url=http://$INGRESS_ENDPOINT" --var "github_username=ajnriva" --var "github_secret=$GITHUB_ACCESS_TOKEN" --var "jenkins_secret=$JENKINS_SECRET" --auto-approve 

##### kubectl file setup with commands
echo "EKS_NAME --> $EKS_NAME"

echo " --------- Get caller identity"
aws sts get-caller-identity

echo " --------- Assume role"
aws sts assume-role --role-arn "arn:aws:iam::725653950044:role/riva-dev-module-test-sqsh" --role-session-name OpenCloudCXEKSSession --query "Credentials" > assume-credentials.json
cat assume-credentials.json

_accessKeyId=$(cat assume-credentials.json |jq -r .AccessKeyId);
_secretAccessKey=$(cat assume-credentials.json |jq -r .SecretAccessKey);
_sessionToken=$(cat assume-credentials.json |jq -r .SessionToken)

echo " --------- Set varibales"

export AWS_ACCESS_KEY_ID=$_accessKeyId
export AWS_SECRET_ACCESS_KEY=$_secretAccessKey
export AWS_DEFAULT_REGION=us-east-1

echo " --------- SECRETS"

echo "Access key --> [$_accessKeyId :: $AWS_ACCESS_KEY_ID]"
echo "Secret key --> [$_secretAccessKey :: $AWS_SECRET_ACCESS_KEY]"
echo "Region     --> [$AWS_DEFAULT_REGION]"

echo " --------- Update kubeconfig"
aws eks update-kubeconfig --name "$EKS_NAME"

# echo " --------- Show config"
# cat /root/.kube/config

echo " --------- TEST COMMAND"

kubectl get pods -A

##### kubectl hal commands
# k exec -it -n spinnaker spinnaker-spinnaker-halyard-0 -- bash -c "hal config ci jenkins enable"
