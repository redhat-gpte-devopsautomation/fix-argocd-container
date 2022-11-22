# Use Red Hat Universal Base Image 9
FROM registry.access.redhat.com/ubi9:latest

ENV OCP_VERSION="4.11"

USER root

COPY fix-argocd.sh /usr/bin/fix-argocd.sh

RUN dnf -y update && \
    dnf -y install wget && \
    chmod +x /usr/bin/fix-argocd.sh && \
    chown -R root:root /usr/bin/fix-argocd.sh && \
    wget -O /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable-${OCP_VERSION}/openshift-client-linux.tar.gz && \
    tar -C /usr/bin -zxvf /tmp/oc.tar.gz && \
    rm /tmp/oc.tar.gz

USER 1001

CMD ["/usr/bin/fix-argocd.sh"]
