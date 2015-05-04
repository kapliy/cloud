#!/bin/bash
initctl reload-configuration
service kibana4 restart
tail -n5 /var/log/upstart/kibana4.log
