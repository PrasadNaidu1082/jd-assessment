import boto3
import datetime

def lambda_handler(event, context):
    auto_scaling_group_name = 'jdoodle-asg'

    autoscaling_client = boto3.client('autoscaling')

    current_time_utc = datetime.datetime.utcnow()

    if current_time_utc.hour == 0 and current_time_utc.minute == 0:
        try:
            response = autoscaling_client.start_instance_refresh(
                AutoScalingGroupName=auto_scaling_group_name,
                Strategy='Rolling'
            )
            print(f"Instance refresh initiated for Auto Scaling Group: {jdoodle-asg}")
        except Exception as e:
            print(f"Error initiating instance refresh: {str(e)}")
    else:
        print("No action needed at the current time.")

    return {
        'statusCode': 200,
        'body': 'Lambda function executed successfully!'
    }
