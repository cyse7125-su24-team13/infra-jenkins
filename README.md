
### README for `infra-jenkins` Repository

```markdownnn
# infra-jenkins

## Overvieww
This repository contains Terraform code and instructions to set up and manage the infrastructure required for a Jenkins instance on AWS. The setup includes networking components, EC2 instance provisioning, and reverse proxy configuration.

## Prerequisites
- AWS account with root access
- AWS CLI installed and configured
- Terraform installed
- GitHub repository set up with the necessary permissions

## Setup Instructions

### AWS CLI Configuration
1. Install and configure the AWS CLI on your development machine.
   ```bash
   aws configure --profile dev
   aws configure --profile prod


### Infrastucture Setup
git clone https://github.com/cyse7125-su24-teamNN/infra-jenkins.git
cd infra-jenkins
terraform init
terraform apply


# Destroy Infrastructure


terraform destroy
test
