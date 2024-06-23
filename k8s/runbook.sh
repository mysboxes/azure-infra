#!/usr/bin/env bash

#kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

export GATEWAY_URL=13.94.146.255:8080
curl -s "http://13.94.146.255:8080/productpage"