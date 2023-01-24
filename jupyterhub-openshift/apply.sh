#!/bin/bash

# execute as kubeadmin (due to rbac & scc requirements)

if ! oc project spark ; then
    oc new-project spark
fi

here=`dirname $(realpath $0 --relative-to .)`

# some things we need additionally to / upfront of the helm chart
oc apply -f $here/resources/route.yaml
oc apply -f $here/resources/rbac.yaml
oc apply -f $here/resources/notebook-build.yaml
oc apply -f $here/resources/hub-build.yaml
oc apply -f $here/resources/service-account-oauth.yaml

TOKEN=$(oc get secret jupyterhub-oauth -o jsonpath='{.data.token}' | base64 -d)
echo "TOKEN: $TOKEN"

# oc create secret generic jupyterhub-oauth --dry-run=client -o yaml --from-literal=oauth_client_secret=$TOKEN | oc apply -f -
# $here/oauth/oauth-service-account-and-secret.sh

helm upgrade --install jupyterhub jupyterhub/jupyterhub -f $here/jupyterhub-values.yaml \
--set hub.config.OpenShiftOAuthenticator.client_secret=$TOKEN \
--set singleuser.storage.extraVolumes[0].hostPath.path=/home/$USER/ecc \
--set singleuser.storage.extraVolumes[1].hostPath.path=/home/$USER/.ssh \
--set singleuser.storage.extraVolumes[2].hostPath.path=/home/$USER/.gitconfig



