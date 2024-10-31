package handlers

import (
	"bucket-explorer/internal/models"
	"encoding/json"
	"net/http"
)

func HealthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	response := models.HealthResponse{
		Status: "OK",
	}

	// Write the JSON response
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(response)
}
