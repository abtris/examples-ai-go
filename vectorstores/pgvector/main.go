package main

import (
	"context"
	"fmt"
	"log"

	examples "github.com/abtris/examples-ai-go/vectorstores"

	"github.com/tmc/langchaingo/llms/ollama"
	"github.com/tmc/langchaingo/vectorstores/pgvector"

	"github.com/tmc/langchaingo/embeddings"
	"github.com/tmc/langchaingo/vectorstores"
)

func main() {
	llm, err := ollama.New(ollama.WithModel("llama3"))
	if err != nil {
		log.Fatal(err)
	}

	e, err := embeddings.NewEmbedder(llm)
	if err != nil {
		log.Fatal(err)
	}

	// Create a new pgvector store.
	ctx := context.Background()
	store, err := pgvector.New(
		ctx,
		pgvector.WithConnectionURL("postgres://testuser:testpass@localhost:5432/testdb?sslmode=disable"),
		pgvector.WithEmbedder(e),
	)
	if err != nil {
		log.Fatal(err)
	}

	// Add documents to the pgvector store.
	_, err = store.AddDocuments(context.Background(), examples.GetData())
	if err != nil {
		log.Fatal(err)
	}

	// Search for similar documents.
	docs, err := store.SimilaritySearch(ctx, "Which of these are cities are located in Japan?", 5, vectorstores.WithScoreThreshold(0.80))
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(docs)

	// Search for similar documents using score threshold.
	docs, err = store.SimilaritySearch(ctx, "Which of these are cities are located in South America?", 1, vectorstores.WithScoreThreshold(0.80))
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(docs)

	// Search for similar documents using score threshold and metadata filter.
	// Metadata filter for pgvector only supports key-value pairs for now.
	filter := map[string]any{"area": "1523", "population": "22.6"}

	docs, err = store.SimilaritySearch(ctx, "Which of these are cities are located in South America?",
		100,
		vectorstores.WithFilters(filter),
	)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(docs)
}
