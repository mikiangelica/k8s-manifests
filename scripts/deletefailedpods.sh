#!/bin/bash

kubectl get pods -A --field-selector=status.phase=Failed -o jsonpath='{range .items[*]}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}' \
| xargs -r -n2 sh -c 'kubectl delete pod -n "$0" "$1"'

