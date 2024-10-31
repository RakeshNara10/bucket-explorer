package handlers

import (
	"encoding/json"
	"log"
	"net/http"

	"bucket-explorer/internal/errors"
	"bucket-explorer/internal/models"
	"bucket-explorer/internal/s3"
)

func ListContentHandler(w http.ResponseWriter, r *http.Request) {
	log.Printf("Received request: %s", r.URL.Path)
	path := r.URL.Path[len("/list-bucket-content/"):]

	contents, err := s3.ListBucketContent(path)
	if err != nil {
		if err == errors.ErrPathNotFound {
			log.Printf("Error: %s (HTTP %d)", err.Error(), http.StatusNotFound)
			http.Error(w, "invalidPath", http.StatusNotFound)
			return
		}
		log.Printf("Error: %s (HTTP %d)", err.Error(), http.StatusInternalServerError)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	response := models.Response{Content: contents}
	log.Printf("Successful response: %v", response.Content)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
