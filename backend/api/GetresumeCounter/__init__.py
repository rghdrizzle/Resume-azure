import logging
import os
from azure.data.tables import TableServiceClient, UpdateMode
import azure.functions as func
import json


conn= os.getenv("AzureResumeConnectionString")
service = TableServiceClient.from_connection_string(conn_str=conn)
table_client = service.get_table_client(table_name="counter")
def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    my_filter = "PartitionKey eq '1' and RowKey eq '1'"
    entities = table_client.query_entities(my_filter)
    for entity in entities:
        for key in entity.keys():
            if key == "count":
                updatedcounter = entity[key]
                entity[key]= updatedcounter+1
                table_client.update_entity(mode=UpdateMode.MERGE, entity=entity)
                response = {
                    "key": "count",
                    "value": updatedcounter
                }
            
    return func.HttpResponse(
        body=json.dumps(response),
        status_code=200,
        mimetype='application/json'
    )
