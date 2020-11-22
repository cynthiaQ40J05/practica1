#PRACTICA 9

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib
import json
import argparse
parser=argparse.ArgumentParser()
parser.add_argument("-message", dest="a", help="mensaje a enviar")
parser.add_argument("-To", dest="b", help= "a quien se le mandara")
parser.add_argument("-Subject", dest="c", help ="asunto")
params=parser.parse_args() 

data = {}

path="C:\\Users\\Cynthia\\Desktop\\info.json"
with open (path) as f:
        data = json.load(f)
# create message object instance
msg = MIMEMultipart()
message =params.a

# setup the parameters of the message
msg['From'] = data['user']

msg['To'] = params.b
msg['Subject'] = params.c


# add in the message body
msg.attach(MIMEText(message, 'plain'))
#create server
server = smtplib.SMTP('smtp.office365.com:587')

server.starttls()

# Login Credentials for sending the mail
print(data['user'])
server.login(data['user'], data['pass'])

# send the message via the server.
server.sendmail(msg['From'], msg['To'], msg.as_string())

server.quit()
print("successfully sent email to %s:" % (msg['To']))
