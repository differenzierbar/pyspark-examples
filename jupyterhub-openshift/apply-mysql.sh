#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami

here=`dirname $(realpath $0 --relative-to .)`

helm upgrade --install mysql bitnami/mysql


