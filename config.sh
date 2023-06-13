#!/bin/bash

subscription_name="DEMO"
environment_name="routers4p"
location="westeurope"
resource_group=$environment_name"rg"

eh_namespace_name="eh4thplatmetrics"
eh_name="security"

eventhub_namespace_domain="servicebus.windows.net"
eventhub_namespace_key_name="RootManageSharedAccessKey"
eventhub_namespace_key_ttl_days=30

time_reference_file=".time"

function get_time_diference {
    start_time=$(head $time_reference_file)
    time_now=$(date +%s)

    if [ $start_time"ff" != "ff" ]
    then
        time_difference=$(expr $time_now - $start_time)
        echo $time_difference
    else
        echo ""
    fi
}
