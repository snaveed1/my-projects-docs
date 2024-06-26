#!/bin/bash

#########################
#Author: Naveed Shaikh
#Date: 02/02/2024
#Purpose: This script tracks the aws resources in your aws account.
#Version: v1
########################

set -x #debug mode

#This command list all the EC2 instances in your Aws Account
echo "Name InstanceId State"
aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | [(.Tags[]? | select(.Key == "Name").Value // "NoName"), .InstanceId, .State.Name] | "\(.[0]) \(.[1]) \(.[2])"'

echo "-------------------------------------------------------------------------------------------------------"

#This command list all the S4 buckets in your Aws Account
echo "Name of S3 Buckets"
aws s3 ls

echo "-------------------------------------------------------------------------------------------------------"

#This command list all the VPC in your Aws Account
echo "Name of all the VPCs"
aws ec2 describe-vpcs --query 'Vpcs[*].[Tags[?Key==`Name`].Value | [0], VpcId]' --output text | awk '{$1=$1;print}'

echo "-------------------------------------------------------------------------------------------------------"

#This command list all the IAM Users in your Aws Account
echo "List of IAM Users and UserId"
aws iam list-users | jq '.Users[] | "\(.UserName) \(.UserId)"

