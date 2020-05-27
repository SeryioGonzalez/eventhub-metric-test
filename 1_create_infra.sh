#!/bin/bash

source config.sh

echo "- Fixing subscription $subscription_name"
az account set --subscription $subscription_name

echo "- Creating rg $resource_group"
az group create --name $resource_group --location $location > /dev/null

echo "- Creating namespace $eh_namespace_name"
az eventhubs namespace create --resource-group $resource_group --name $eh_namespace_name
   
echo "-- Creating eventhub $eh_name in namespace $eh_namespace_name"
az eventhubs eventhub create --resource-group $resource_group --namespace-name $eh_namespace_name --name $eh_name

echo "-- Storing time reference"
date +%s > $time_reference_file

creation_date=$(date +%H:%M:%S)
echo "-- Event hub created at $creation_date"