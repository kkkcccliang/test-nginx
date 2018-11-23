#!/bin/bash

url='http://localhost:8081'

echo "\n==== $url/proxy1/index.html"
curl $url/proxy1/index.html

echo "\n==== $url/proxy2/index.html"
curl $url/proxy2/index.html

echo "\n==== $url/proxy3/somewhere/index.html"
curl $url/proxy3/somewhere/index.html

echo "\n==== $url/proxy4/somewhere/index.html"
curl $url/proxy4/somewhere/index.html

echo "\n==== $url/proxy5/somewhere/test.html"
curl $url/proxy5/somewhere/test.html

echo "\n==== $url/proxy6/somewhere/test.html"
curl $url/proxy6/somewhere/test.html

