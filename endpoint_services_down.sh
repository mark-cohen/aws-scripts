#!/usr/bin/env bash

# this script uses the awscli to destroy VPC endpoints with specific tags.
# simply specify your profile, region, and tags, and test with --dry-run flag.
# if tests return "Request would have succeeded, but DryRun flag is set", then
# simply comment out the --dry-run flag to actually perform the operation, and destroy the endpoints.

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
    --vpc-endpoint-ids $ENDPOINTIDS \
    --region $REGION \
    --profile $PROFILE \
    --dry-run

exit

