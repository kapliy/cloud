#!/usr/bin/env python

import sys
import requests
import logging
import json
logging.basicConfig(level=logging.INFO)

port = 4400
server = 'http://localhost'

url = '{}:{}/scheduler/'.format(server, port)
if len(sys.argv) > 1:
    url += 'job/{}'.format(sys.argv[1])
else:
    url += 'jobs'
z = requests.get(url)

if z.status_code != 200:
    logging.error('Bad status code = {}'.format(z.status_code))
    sys.exit(1)

print json.dumps(z.json(), sort_keys=True, indent=4, separators=(',', ': '))

