#!/bin/bash

service nginx start
sleep 5
curl http://localhost/index.html

exit $?
