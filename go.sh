#!/bin/bash

##### Add jenkins jobx
terraform init
terraform apply -var "jenkins_url=$INGRESS_ENDPOINT" --var "github_username=ajnriva" --var "github_secret=$GITHUB_ACCESS_TOKEN" --var "jenkins_secret=$JENKINS_SECRET" --auto-approve 

##### kubectl file setup with commands


##### kubectl hal commands
# k exec -it -n spinnaker spinnaker-spinnaker-halyard-0 -- bash -c "hal config ci jenkins enable"
