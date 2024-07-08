# https://suva.sh/posts/well-documented-makefiles/#simple-makefile
.DEFAULT_GOAL:=help
SHELL:=/bin/bash

.PHONY: help deps clean build watch

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

chroma:  ## Run chrome vector store
	docker run -p 8000:8000 ghcr.io/chroma-core/chroma:0.5.0

ollama-pull:
	ollama pull mxbai-embed-large
	ollama pull llama3

chroma-example: ## Run example chrome
	go run vectorstores/chroma/main.go

pgvector-example: ## Run example pgvector
	go run vectorstores/pgvector/main.go


example1: ## Run simple ollama example
	go run examples/ollama-single-prompt/main.go

example1-stream: ## Run simple ollama example streaming
	go run examples/ollama-single-prompt-streaming/main.go

example-embeddings: ## Run ollama embeddings example
	go run examples/ollama-embeddings/main.go