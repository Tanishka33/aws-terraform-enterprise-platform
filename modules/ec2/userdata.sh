#!/bin/bash

yum update -y

yum install -y httpd aws-cli

systemctl start httpd
systemctl enable httpd

echo "<h1>${environment} Server from Terraform</h1>" > /var/www/html/index.html

YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)

TIME=$(date +%H-%M-%S)

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

LOG_FILE="server-log-$TIME.txt"

echo "Terraform Enterprise Platform Log" >> /tmp/$LOG_FILE
echo "" >> /tmp/$LOG_FILE

echo "Environment: ${environment}" >> /tmp/$LOG_FILE

echo "Timestamp: $TIMESTAMP" >> /tmp/$LOG_FILE

echo "Hostname: $(hostname)" >> /tmp/$LOG_FILE

echo "AWS Region: ${aws_region}" >> /tmp/$LOG_FILE

echo "IAM Role Authentication: SUCCESS" >> /tmp/$LOG_FILE

echo "Terraform Managed Infrastructure: TRUE" >> /tmp/$LOG_FILE

aws s3 cp /tmp/$LOG_FILE s3://${bucket_name}/$YEAR/$MONTH/$DAY/$LOG_FILE