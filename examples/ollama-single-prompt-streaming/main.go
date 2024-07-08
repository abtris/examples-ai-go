package main

import (
	"context"
	"fmt"
	"log"

	"github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/llms/ollama"
)

func main() {
	llm, err := ollama.New(ollama.WithModel("llama3"))
	if err != nil {
		log.Fatal(err)
	}

	query := "very briefly, tell me the difference between a comet and a meteor"

	ctx := context.Background()
	_, err = llms.GenerateFromSinglePrompt(ctx, llm, query,
		llms.WithStreamingFunc(func(ctx context.Context, chunk []byte) error {
			fmt.Printf("%s", chunk)
			return nil
		}))
	if err != nil {
		log.Fatal(err)
	}
}
