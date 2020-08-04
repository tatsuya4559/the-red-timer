.PHONY: build
build:
	docker build . -t svelte

.PHONY: run
run:
	docker run --rm -itd --name svelte -p 1234:1234 svelte

.PHONY: stop
stop:
	docker stop svelte
