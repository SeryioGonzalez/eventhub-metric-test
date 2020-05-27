#!/bin/bash

source config.sh

eventhub_namespace_key=$(az eventhubs namespace authorization-rule keys list -g $resource_group --namespace $eh_namespace_name -n $eventhub_namespace_key_name --query "primaryKey" -o tsv)
connection_string="Endpoint=sb://$eh_namespace_name.servicebus.windows.net/;SharedAccessKeyName=$eventhub_namespace_key_name;SharedAccessKey=$eventhub_namespace_key"

time_delta=$(get_time_diference)
echo "Starting sending data after $time_delta seconds after creation"

while true
do
    time_delta=$(get_time_diference)
    python3 event-hub-message-sender.py $connection_string $eh_name $time_delta
done