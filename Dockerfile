FROM google/cloud-sdk:alpine

ENV HELM_VERSION="v2.6.2" \
	HELM_SHASUM="ba807d6017b612a0c63c093a954c7d63918d3e324bdba335d67b7948439dbca8"
	
RUN \
	# Install Helm \
	HELM_URL="https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
	HELM_PACKAGE="/tmp/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
    curl -o "${HELM_PACKAGE}" "${HELM_URL}" && \
    (echo "${HELM_SHASUM}  ${HELM_PACKAGE}" | sha256sum -c -) && \
    tar xzf "${HELM_PACKAGE}" -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    helm init --client-only && \
	# Install Google Cloud SDK components \
	gcloud components install --quiet kubectl alpha beta && \
	# Install build tools \
    apk add --no-cache --virtual build_deps gettext && \
    apk add --no-cache make libintl && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps && \
    rm -rf /tmp/*
    