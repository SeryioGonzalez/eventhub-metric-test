source config.sh

resource_id=$(az eventhubs namespace show -g $resource_group -n $eh_namespace_name --query "id" -o tsv)

while true
do
    date_format=$(date +%Y-%m-%dT)
    az monitor metrics list --resource $resource_id --metric SuccessfulRequests --aggregation Total --query "value[0].timeseries[0].data[].{timeStamp:timeStamp, total:total}" -o tsv | sed "s/$date_format//"
done