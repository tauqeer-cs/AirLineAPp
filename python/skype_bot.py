h='r'
g='System.Title'
f='System.WorkItemType'
e='{0} {1}: {2}'
d=open
B=print
import requests,sys,getopt as F,os
from skpy import Skype
from vsts.vss_connection import VssConnection as L
from msrest.authentication import BasicAuthentication as M
import json
from vsts.work_item_tracking.v4_1.models.wiql import Wiql
def N(msg,*A):B(msg%A)
def i(work_item):A=work_item;N(e.format(A.fields[f],A.id,A.fields[g]))
O='co7saevupd7v7t7znzr3ly5hthg5bduveu2uo473mhdzdnt3a4oq'
P='https://dev.azure.com/alphareds'
Q=M('',O)
R=L(base_url=P,creds=Q)
S=Skype('dariusbot.dev@hotmail.com','Airlines1234!')
j='19:52782e090a7847bf9d6f17e5c4e0119c@thread.skype'
T='19:d1ccf677216e405e8b9a2d31d938b23c@thread.skype'
U=S.chats.chat(T)
A=d('../releases_notes.txt',h)
C=A.readline().strip()
k=A.readlines()
A.close()
A=d('../pubspec.yaml',h)
V=A.readlines()
A.close()
G=[]
for H in V:
    if'version:'in H.split():B('contains version');W=H.split(' ');C=W[1];break
B('version is '+C)
X="SELECT [System.Id] FROM workitems WHERE [System.Tags] Contains '{}'".format(C)
Y=Wiql(query=X)
I=R.get_client('vsts.work_item_tracking.v4_1.work_item_tracking_client.WorkItemTrackingClient')
J=I.query_by_wiql(Y).work_items
if J:
    Z=(I.get_work_item(int(A.id))for A in J)
    for D in Z:G.append(e.format(D.fields[f],D.id,D.fields[g]))
K='\n'.join(G)
B(K)
E=''
try:a,l=F.getopt(sys.argv[1:],'n:',['name='])
except F.GetoptError:B('python skypebot.py -n Staging|Production');sys.exit(2)
for (b,c) in a:
    if b in('-n','--name'):E=c
B(E)
U.sendMsg('New release version: '+C+'\nEnv: IOS and Android '+E+'\nDeployed Task:\n\n'+K)