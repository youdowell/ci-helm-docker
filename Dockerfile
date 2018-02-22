FROM google/cloud-sdk:alpine

ENV HELM_VERSION="v2.8.1"

RUN \
	# Install Helm \
	HELM_URL="https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
	HELM_PACKAGE="/tmp/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
	\
	(cd /tmp; wget --quiet -O - $HELM_URL | tar zx; mv linux-amd64/helm /usr/bin/) && \
	\
	helm init --client-only && \
	\
	# Install Google Cloud SDK components \
	gcloud components install --quiet kubectl alpha beta && \
	\
	# Install build tools \
	apk add --no-cache --virtual .build_deps gettext && \
	apk add --no-cache make libintl && \
	cp /usr/bin/envsubst /usr/local/bin/envsubst && \
	apk del .build_deps && \
	rm -rf /tmp/*
