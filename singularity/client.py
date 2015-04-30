#!/usr/bin/env python

import sys
import os
import argparse
import requests
import json


class SingularityAPI(object):

    def __init__(self, endpoint, verbose=2):
        """ Arguments:
        - endpoint  - URL endpoint that exposes the Singularity API 
        - verbose   - integer flag controlling verbosity level (0=lowest verbosity)
        """
        self.endpoint = endpoint
        self.verbose = verbose

    def _handle_response(self, r):
        status = r.status_code
        r.raise_for_status()
        j = r.json()
        if self.verbose:
            print json.dumps(j, sort_keys=True, indent=4)
        return j

    def _process_json(self, jsn):
        """
        Converts jsn (json string, python dict, or json file on disk)
        to a json string that can be posted to the API endpoint
        """
        if os.path.isfile(jsn):
            return open(args.json, 'r').read()
        elif isinstance(jsn, dict):
            return json.dumps(jsn)
        return jsn

    def deploy(self, jsn):
        """
        Deploys an existing json file
        Arguments:
        - jsn     - json string describing the deployment
        """
        jsn = self._process_json(jsn)
        url = os.path.join(self.endpoint, 'deploys')
        if self.verbose:
            print url
        headers = {'Content-Type': 'application/json'}
        r = requests.post(url, data=jsn, headers=headers)
        return self._handle_response(r)

    def add(self, jsn):
        """
        Adds a Request to Singularity specified via a json string
        Arguments:
        - jsn     - json string, python dict, or json file on disk
        """
        jsn = self._process_json(jsn)
        url = os.path.join(self.endpoint, 'requests')
        if self.verbose:
            print url
        headers = {'Content-Type': 'application/json'}
        r = requests.post(url, data=jsn, headers=headers)
        return self._handle_response(r)
        
    def run(self, request):
        url = os.path.join(self.endpoint, 'requests', 'request', request, 'run')
        if self.verbose:
            print url
        r = requests.post(url)
        return self._handle_response(r)
        
    def ls(self):
        url = os.path.join(self.endpoint, 'requests')
        if self.verbose:
            print url
        r = requests.get(url)
        return self._handle_response(r)

    def get(self, request):
        url = os.path.join(self.endpoint, 'requests', 'request', request)
        if self.verbose:
            print url
        r = requests.get(url)
        return self._handle_response(r)
    
    def destroy(self, request):
        url = os.path.join(self.endpoint, 'requests', 'request', request)
        if self.verbose:
            print url
        r = requests.delete(url)
        return self._handle_response(r)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='API frontend for the Singularity/Mesos scheduler')
    parser.add_argument('--endpoint', '--api', '--url', dest='endpoint',
                        help='URL endpoint that exposes the API',
                        type=str, default='http://bos-rndjob2:7099/singularity/api')
    parser.add_argument('-a', '--action', dest='action',
                        help='API action to perform',
                        type=str, default='ls')
    parser.add_argument('-n', '--name', '--request', dest='request',
                        help='Name of the request',
                        type=str, default=None)
    parser.add_argument('-j', '--json', dest='json',
                        help='A json object - either as a string or file',
                        type=str, default=None)

    args = parser.parse_args()
    # init the API wrapper
    api = SingularityAPI(args.endpoint, verbose=True)
    # process requested action
    if args.action in ('ls', 'get'):
        if args.request:
            api.get(args.request)
        else:
            api.ls()
    elif args.action in ('run',):
        if not args.request:
            raise ValueError('please supply Singularity request name via --request')
        api.run(args.request)
    elif args.action in ('rm', 'del', 'delete', 'destroy'):
        if not args.request:
            raise ValueError('please supply Singularity request name via --request')
        api.destroy(args.request)
    elif args.action in ('add',):
        if not args.json:
            raise ValueError('please supply a json file via --json')
        api.add(args.json)
    elif args.action in ('deploy', ):
        if not args.json:
            raise ValueError('please supply a json file via --json')
        api.deploy(args.json)
