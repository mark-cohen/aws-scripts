#!/usr/bin/env bash

# replace PROFILE, REGION and DBCLUSTERID values ("NameOfProfile", "NameOfRegion", "NameOfDBCluster")
# as per your own environment. 

# specify AWS profile:
PROFILE="your_aws_profile"
# specify region:
REGION="your_aws_region"
# specify db instance name: 
DBCLUSTERID="your-db-cluster"
# check if db is instance present:
DBCLUSTEREPRESENT=$(aws rds describe-db-instances \
    --query 'DBInstances[*].[DBClusterIdentifier]' \
    --filters Name=db-cluster-id,Values=$DBCLUSTERID \
    --output text \
    --region $REGION \
    --profile $PROFILE     
    )
STATUS=$(aws rds describe-db-instances \
    --query 'DBInstances[*].[DBInstanceStatus]' \
    --filters Name=db-cluster-id,Values=$DBCLUSTERID \
    --output text \
    --region $REGION \
    --profile $PROFILE     
    )

# command to start db-cluster for testing script:
# aws rds start-db-cluster --db-cluster-identifier "$DBCLUSTERID" --region $REGION --profile $PROFILE

# verify the cluster exists and is running, and if so, bring the RDS environment down:
if [ -z $DBCLUSTEREPRESENT ]
 then
    echo "instance $DBCLUSTERID does not exist."
 else 
  if
   [ $DBCLUSTEREPRESENT ] && [ $STATUS != available ]
   then
       echo "instance $DBCLUSTERID exists, but is $STATUS."
   else
   [ $DBCLUSTEREPRESENT ] && [ $STATUS = available ]
   echo "instance $DBCLUSTERID exists and is running, initating shutdown."
   aws rds stop-db-cluster --db-cluster-identifier "$DBCLUSTERID" --region $REGION --profile $PROFILE
fi
fi

exit
