FROM alpine as builder

ARG KUBECTL_VERSION="v1.19.0"
ARG HELM_VERSION="v3.3.1"

RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && wget -O helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar xf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/helm

FROM alpine

LABEL maintainer="Lukas Steiner <lukas.steiner@siticom.de>"
LABEL kubectl_version=${KUBECTL_VERSION}
LABEL helm_version=${HELM_VERSION}

COPY --from=builder /usr/local/bin /usr/local/bin
