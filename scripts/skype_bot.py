import requests
import sys
import getopt
import os
from skpy import Skype
skype_obj = Skype("dariusbot.dev@hotmail.com","Airlines1234!")
testgroup = "19:52782e090a7847bf9d6f17e5c4e0119c@thread.skype"
airlinesgrup = "19:d1ccf677216e405e8b9a2d31d938b23c@thread.skype"
channel = skype_obj.chats.chat(testgroup)
f = open('../releases_notes.txt', 'r')
flutter_version = f.readline().strip()
lines = f.readlines()
f.close()
value = []
for x in lines:
    print("lines is "+x)
    if '###' in x.split():
        split_message = x.split(' ')
        split_message.pop(0)
        parsing_text = " ".join(split_message)
        value.append(parsing_text)
    else:
        print("else is "+x)
        value.append(x) 
result = "".join(value)

# get command
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
channel.sendMsg("New release version: "+flutter_version+"\nEnv: "+env+"\nRelease Notes:"+result)