#!/bin/bash

oc apply -f service-account-oauth.yaml

SECRET_NAMES=$(oc get sa jupyterhub-oauth -o jsonpath='{.secrets[*].name}')


for val in $SECRET_NAMES; do
    [[ $val =~ ^jupyterhub-oauth-token ]] && SECRET_NAME=$val
done

TOKEN=$(oc get secret $SECRET_NAME -o jsonpath='{.data.token}' | base64 -d)

oc create secret generic jupyterhub-oauth --dry-run=client -o yaml --from-literal=oauth_client_secret=$TOKEN | oc apply -f -


