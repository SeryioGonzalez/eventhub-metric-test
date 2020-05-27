from azure.eventhub import EventHubProducerClient, EventData
import sys

CONNECTION_STRING = sys.argv[1]
EVENT_HUB_NAME    = sys.argv[2]
TIME_DELTA        = sys.argv[3]

event_hub_client = EventHubProducerClient.from_connection_string(CONNECTION_STRING, eventhub_name=EVENT_HUB_NAME)

event_data_batch = event_hub_client.create_batch(max_size_in_bytes=10000)
can_add = True
while can_add:
    try:
        event_data_batch.add(EventData('Message inside EventBatchData'))
    except ValueError:
        can_add = False  # EventDataBatch object reaches max_size.

with event_hub_client:
    event_hub_client.send_batch(event_data_batch)

#print("Data sent {:3} seconds after".format(TIME_DELTA))