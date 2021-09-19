#!/bin/bash

##### Add jenkins jobx
terraform apply -var "jenkins_url=$INGRESS_ENDPOINT " --auto-approve 

##### kubectl file setup with commands


##### kubectl hal commands
# k exec -it -n spinnaker spinnaker-spinnaker-halyard-0 -- bash -c "hal config ci jenkins enable"
