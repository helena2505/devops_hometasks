#!/usr/bin/python3

import os
from datetime import datetime

print("Content-Type: text/html\n")
print('<h1>Hello from python!</h1>')
now = datetime.now()
print('<p>Date: ', now, '</p>')
print('<p>Browser info: ', os.environ.get('HTTP_USER_AGENT', ''), '</p>')

