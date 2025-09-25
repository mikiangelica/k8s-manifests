#!/bin/bash

kubectl port-forward svc/jenkins -n jenkins 8080:8080

