resource "aws_launch_configuration" "ubuntu-jdoodle" {
  name = "jdoodle_config"
  image_id = "ami-03f4878755434977f"  
  instance_type = "t2.micro"
  key_name = "key2024" 
  user_data            = <<-EOF
                          touch 
                          #!/bin/bash
                          echo "load=$( cat /proc/loadavg | awk '{print $2;}' )" >> customalert.sh
                          echo "id=`cat /var/lib/cloud/data/instance-id`" >> customalert.sh
                          echo "aws cloudwatch put-metric-data --metric-name=Avgload  --namespace InstanceLoad  --dimensions Instance=$id --value $load" >> customalert.sh 
                          chmod +x customalert.sh
                          sleep 5
                          (crontab -l ; echo "*/5 * * * * /home/ubuntu/custom-metrics.sh") 
                          EOF
}
