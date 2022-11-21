#!/bin/bash
VERSION=v1.0.0

podman build . -t quay.io/gpte-devops-automation/fix-argocd:latest
podman tag quay.io/gpte-devops-automation/fix-argocd:latest quay.io/gpte-devops-automation/fix-argocd:${VERSION}
podman push quay.io/gpte-devops-automation/fix-argocd:latest
podman push quay.io/gpte-devops-automation/fix-argocd:${VERSION}
