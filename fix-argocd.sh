#!/bin/bash
# Fix ArgoCD. Sleep SETUP_DELAY minutes then delete all dex pods (for the pods to pick up the OpenShift
#   authentication endpoint) and delete the OpenShift Gitops Repo server (to clean up any
#   repo locks in the ephemeral storage).
#   SETUP_DELAY needs to be set as an environment variable. If it is not set then a default of 1 minute
#   is assumed.
#
# Usage:
#   export SETUP_DELAY=10; fix-argocd.sh

SETUP_DELAY=${SETUP_DELAY:-"1"}

echo "---------------------------------------------"
echo "Sleeping ${SETUP_DELAY} minutes..."
echo "---------------------------------------------"
sleep ${SETUP_DELAY}m

echo "-----------------------------------------------------"
echo "Deleting all argocd-dex-server pods on the cluster..."
echo "-----------------------------------------------------"
oc delete pod -A -l app.kubernetes.io/name=argocd-dex-server

echo "---------------------------------------------"
echo "Deleting openshift-gitops-repos-server pod..."
echo "---------------------------------------------"
oc delete pod -l app.kubernetes.io/name=openshift-gitops-repo-server -n openshift-gitops

echo "---------------------------------------------"
echo "All done."
echo "---------------------------------------------"
