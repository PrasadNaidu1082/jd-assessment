# Autoscaling and Refresh task 

<img width="419" alt="Jdoodle architecture" src="https://github.com/PrasadNaidu1082/jd-assessment/assets/36126926/427fd00b-b09f-43ed-a1b2-bc38429a51fc">



Overview This repository contains Terraform scripts to set up an AWS Autoscaling Group based on load average conditions, including scaling policies and daily machine refresh.

Prerequisites Before running the Terraform scripts, ensure you have:

AWS CLI configured with appropriate permissions. Terraform installed on your machine

Configuration

Clone the Repository: git clone https://github.com/yourusername/aws-autoscaling-assessment.git cd aws-autoscaling-assessment

AWS Credentials: Ensure your AWS credentials are configured. You can use the following AWS CLI command: aws configure

Please take a look at the modules used below with descriptions. launchconfig.tf: Consists of launch configuration.

autoscaling.tf: Consist of autoscaling group, and autoscaling policy configuration.

cloudwatch.tf: Consists of cloudwatch metric alarm, event rule, and event target.

iam.tf: Consist of iam role for cloudwatch, autoscaling refresh role, iam policy for autoscaling refresh, iam policy for cloudwatch alarm, iam role policy attachment for cloudwatch and autoscaling policy configuration.

networkconfig.tf: Consists of vpc, subnets, internet gateway, route table, route table association, and security group configuration.

provider.tf: Consist of provider details.

refreshevent.tf: Consist of cloudwatch event rule and target for refresh task configuration.

snstopic.tf: Consist of sns topic subscription, cloudwatch event target refresh task notification configuration.

Autoscaling Group Configuration The Terraform scripts configure an AWS Autoscaling Group with the following specifications:

Minimum instances: 2 Maximum instances: 5

Scaling Policies Two CloudWatch Alarms are set up to trigger scaling policies:

Scale Up Policy:

When the 5-minute load average of the machines reaches 75%, a new instance is added. Scale Down Policy:

When the 5-minute load average of the machines reaches 50%, a machine is removed.

Scaling Policies Two CloudWatch Alarms are set up to trigger scaling policies:

1.Scale Up Policy:

When the 5-minute load average of the machines reaches 75%, a new instance is added.

2.Scale Down Policy:

When the 5-minute load average of the machines reaches 50%, a machine is removed.

Daily Machine Refresh Everyday at 12 am UTC, all machines in the group are refreshed: Old machines are removed. New machines are added.

Email Alerts Email alerts are configured for scaling and refresh events using AWS SNS. You will receive notifications when scaling up, scaling down, or during the daily machine refresh.
