PROJECT				?= $(notdir $(patsubst %/,%,$(CURDIR)))
PACKAGE_VERSION		:= $(shell node -e 'console.log(require("./package.json").version)')
VERSION				?= $(PACKAGE_VERSION)

IMAGE	            := youdowell/$(PROJECT)
TAG					?= v$(VERSION)

.PHONY: all info build publish version

all: build

info:
	@echo "PROJECT: $(PROJECT)"
	@echo "VERSION: $(VERSION)"
	@echo "TAG:     $(TAG)"
	@echo "CHART:   $(CHART)"
	@echo "RELEASE: $(RELEASE)"

build:
	docker build -t $(IMAGE):$(TAG) --rm .

publish:
	docker push $(IMAGE):$(TAG)

version:
	@echo "New version: ${VERSION}"
