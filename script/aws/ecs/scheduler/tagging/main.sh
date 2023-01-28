#!/bin/bash

# ENVIRONMENT VARIABLES
KEY='scheduler'

CLUSTER_LIST="<cluser_name>"

PROFILE='default'
ACCOUNT_ID='112345678'
REGION="ap-northeast-2"

# PUT tags to the cluster
for CLUSTER in $CLUSTER_LIST; do
  CLUSTER_ARN="arn:aws:ecs:$REGION:$ACCOUNT_ID:cluster/$CLUSTER"
  aws ecs tag-resource --resource-arn $CLUSTER_ARN --tags key=$KEY,value=true --profile $PROFILE
  echo "Tagged $CLUSTER_ARN"
