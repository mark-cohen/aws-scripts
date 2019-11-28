#!/usr/bin/env bash

# specify AWS profile:
PROFILE="your_aws_profile"
# specify region:
REGION="your_aws_region"
# get VPC endpoints:
ENDPOINTIDS=$(aws ec2 describe-vpc-endpoints \
--query 'VpcEndpoints[*].[VpcEndpointId]' \
--filters Name=tag:your_tag1,Values=your_tag_value1 \
--output text \
--region $REGION \
--profile $PROFILE
)

echo "the following endpoints will be deleted: $ENDPOINTIDS"

# delete endpoint(s)
aws ec2 delete-vpc-endpoints \
    --vpc-endpoint-ids $ENDPOINTIDS
    --region $REGION \
    --profile $PROFILE \
# test first with --dry-run flag, then remove or comment out
    --dry-run

exit

