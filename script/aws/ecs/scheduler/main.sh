#!/bin/bash

# ENVIRONMENT VARIABLES
KEY='scheduler'
PROFILE='default'

# This script is used to ECS scheduler container.
CLUSTER_LiST=$(aws ecs list-clusters --profile $PROFILE | jq -r '.clusterArns[]')

# Check if the cluster has the tag 'scheduler'
for CLUSTER_ARN in $CLUSTER_LiST; do
  VALUE=$(aws ecs list-tags-for-resource --resource-arn $CLUSTER_ARN --profile $PROFILE --query "tags[?key==\`${KEY}\`].value" | jq -r .[])
  
  # Check if the value is true ignore case
  VALUE_CHK=$(echo $VALUE | grep -i -w "true" | wc -l)
  if [[ $VALUE_CHK -ge 1 ]]; then
    # Get cluster name
    CLUSTER=$(echo $CLUSTER_ARN | cut -d'/' -f2)

    # Check if time over 12:00:00
    HOUR=$(echo `date +%T` | cut -d':' -f1)
    # If time is under 12:00:00, start the cluster
    if [ $HOUR -lt 12 ]; then
      aws ecs update-service --cluster $CLUSTER --service $CLUSTER --desired-count 1 > /dev/null 2>&1
      echo "Cluster $CLUSTER is running"
    else
      # If time is over 12:00:00, stop the cluster
      aws ecs update-service --cluster $CLUSTER --service $CLUSTER --desired-count 0 > /dev/null 2>&1
      echo "Cluster $CLUSTER is stopped"
    fi
  fi
done

