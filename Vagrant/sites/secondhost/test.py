#!/usr/bin/env python3
import sys
import hashlib
from datetime import datetime
input=sys.argv[1]

hash_object = hashlib.md5(input)
print('Current date: '+ datetime.today().strftime('%Y-%m-%d'))
print('Browser fingerprint: '+hash_object.hexdigest())
