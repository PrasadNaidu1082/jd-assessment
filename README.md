Overview
This repository contains Terraform scripts to set up an AWS Autoscaling Group based on load average conditions, including scaling policies and daily machine refresh.

Prerequisites
Before running the Terraform scripts, ensure you have:

AWS CLI configured with appropriate permissions.
Terraform installed on your machine

Configuration
1. Clone the Repository:
git clone https://github.com/yourusername/aws-autoscaling-assessment.git
cd aws-autoscaling-assessment

2. AWS Credentials:
Ensure your AWS credentials are configured. You can use the following AWS CLI command:
aws configure

3. Please take a look at the modules used below with descriptions.
launchconfig.tf: Consists of launch configuration.
autoscaling.tf: Consist of autoscaling group, and autoscaling policy configuration.  
cloudwatch.tf: Consists of cloudwatch metric alarm, event rule, and event target.
iam.tf:  Consist of iam role for cloudwatch, autoscaling refresh role, iam policy for autoscaling refresh, iam policy for cloudwatch alarm, iam role policy attachment for cloudwatch and autoscaling policy configuration.
networkconfig.tf: Consists of vpc, subnets, internet gateway, route table, route table association, and security group configuration.
provider.tf: Consist of provider details.
refreshevent.tf: Consist of cloudwatch event rule and target for refresh task configuration.
snstopic.tf: Consist of sns topic subscription, cloudwatch event target refresh task notification configuration.
 



