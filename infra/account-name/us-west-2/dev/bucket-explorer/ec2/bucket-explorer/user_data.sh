#!/bin/bash -ex
cd /home/ec2-user
aws s3 cp s3://test-bucket-rakesh11/bucket-explorer /home/ec2-user/
sudo chmod +x /home/ec2-user/bucket-explorer
nohup ./bucket-explorer &
