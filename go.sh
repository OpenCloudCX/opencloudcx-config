#!/bin/bash

##### Add jenkins jobx
terraform init
terraform apply -var "jenkins_url=http://$INGRESS_ENDPOINT" --var "github_username=ajnriva" --var "github_secret=$GITHUB_ACCESS_TOKEN" --var "jenkins_secret=$JENKINS_SECRET" --auto-approve 

##### kubectl file setup with commands
echo "EKS_NAME --> $EKS_NAME"

echo " --------- Get caller identity"
# aws sts get-caller-identity

echo " --------- Assume role"
# aws sts assume-role --role-arn "arn:aws:iam::725653950044:role/riva-dev-module-test-sqsh-eks" --role-session-name OpenCloudCXEKSSession

echo " --------- Get caller identity - 2"
aws sts get-caller-identity

echo " --------- Update kubeconfig"
aws eks --region us-east-1 update-kubeconfig --name "$EKS_NAME"

echo " --------- Show config"
cat /root/.kube/config



kubectl get pods -A

##### kubectl hal commands
# k exec -it -n spinnaker spinnaker-spinnaker-halyard-0 -- bash -c "hal config ci jenkins enable"
