NAME = youdowell/ci-helm
VERSION ?= snapshot

.PHONY: all build release
all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

release:
	@if ! docker images $(NAME):$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker tag $(NAME):$(VERSION) $(NAME):latest
	docker push $(NAME)
