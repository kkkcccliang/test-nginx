#!/bin/bash

docker run -d --name=test-nginx-proxypass1 -p 8081:80 \
  -v `pwd`/nginx1/logs:/etc/nginx/logs \
  -v `pwd`/nginx1.conf:/etc/nginx/nginx.conf \
  nginx

docker run -d --name=test-nginx-proxypass2 -p 8082:80 \
  -v `pwd`/nginx2/logs:/etc/nginx/logs \
  -v `pwd`/nginx2.conf:/etc/nginx/nginx.conf \
  -v `pwd`/nginx2:/usr/share/nginx/html \
  nginx

