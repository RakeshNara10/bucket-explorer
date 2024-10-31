package main

import (
	"bucket-explorer/config"
	"bucket-explorer/internal/handlers"

	"log"
	"net/http"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("GET /health", handlers.HealthHandler)
	mux.HandleFunc("GET /list-bucket-content/", handlers.ListContentHandler)
	port := config.GetPort()

	log.Printf("Listening on port %s\n", port)
	if err := http.ListenAndServe(":"+port, mux); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
