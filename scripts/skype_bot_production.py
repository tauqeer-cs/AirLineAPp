import requests
import sys
import getopt
import os
from skpy import Skype
from vsts.vss_connection import VssConnection
from msrest.authentication import BasicAuthentication
import json
from vsts.work_item_tracking.v4_1.models.wiql import Wiql


def emit(msg, *args):
    print(msg % args)


def print_work_item(work_item):
    emit(
        "{0} {1}: {2}".format(
            work_item.fields["System.WorkItemType"],
            work_item.id,
            work_item.fields["System.Title"],
        )
    )


token = 'abkh2ehdqp5imbq6meo276pq3m3ckkbhjkiyi3sj5pijiepfnd4a'
url = 'https://dev.azure.com/alphareds'
# Create a connection to the org
credentials = BasicAuthentication('', token)
connection = VssConnection(base_url=url, creds=credentials)

skype_obj = Skype("dariusbot.dev@hotmail.com", "Airlines1234!")
testgroup = "19:52782e090a7847bf9d6f17e5c4e0119c@thread.skype"
airlinesgrup = "19:d1ccf677216e405e8b9a2d31d938b23c@thread.skype"
channel = skype_obj.chats.chat(airlinesgrup)
f = open('../releases_notes.txt', 'r')
flutter_version = f.readline().strip()
lines = f.readlines()
f.close()
f = open('../pubspec.yaml', 'r')
linesPubSpec = f.readlines()
f.close()
prodList = ""
value = []
for x in linesPubSpec:
    if 'version:' in x.split():
        print("contains version")
        split_message = x.split(' ')
        flutter_version = split_message[1]
        break
    if '#prodlist:' in x.split():
        print("contains production")
        split_message = x.split(':')
        prodList = split_message[1]
        break
prodList = prodList.replace(" ", "")
versions = prodList.split(",")
print("version is "+",".join(versions))
query = "SELECT [System.Id] FROM workitems WHERE"
for index, version in enumerate(versions):
    if (index == 0):
        addQuery = "[System.Tags] Contains '{}'".format(version)
    elif (index+1 == versions.count):
        addQuery = "\nOR [System.Tags] Contains '{}'".format(version)
    else:
        addQuery = "\nOR [System.Tags] Contains '{}'".format(version)
    query += addQuery


print("query is "+query)

wiql = Wiql(query=query)

wit_client = connection.get_client(
    'vsts.work_item_tracking.v4_1.work_item_tracking_client.WorkItemTrackingClient')
wiql_results = wit_client.query_by_wiql(wiql).work_items
if wiql_results:
    print("inside wiql result")
    # WIQL query gives a WorkItemReference with ID only
    # => we get the corresponding WorkItem from id
    work_items = (
        wit_client.get_work_item(int(res.id)) for res in wiql_results
    )
    for work_item in work_items:
        value.append("{0} {1}: {2}".format(
            work_item.fields["System.WorkItemType"],
            work_item.id,
            work_item.fields["System.Title"],
        ))
        # print_work_item(work_item)
# get command
print("result is")
result = "\n".join(value)
print(result)
env = ''
try:
    opts, args = getopt.getopt(sys.argv[1:], "n:", ["name="])
except getopt.GetoptError:
    print("python skypebot.py -n Staging|Production")
    sys.exit(2)
for opt, arg in opts:
    if opt in ("-n", "--name"):
        env = arg
print(env)
channel.sendMsg("New Production Release:\n"+", ".join(versions) +
                "\nEnv: IOS and Android \nDeployed Task Since Last Release:\n\n"+result)