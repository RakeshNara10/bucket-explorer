APP_NAME=bucket-explorer
SRC=./cmd/bucket-explorer/main.go
OUTPUT_DIR=.

build-windows:
	GOOS=windows GOARCH=amd64 go build -o $(OUTPUT_DIR)/$(APP_NAME).exe $(SRC)

build-linux:
	GOOS=linux GOARCH=amd64 go build -o $(OUTPUT_DIR)/$(APP_NAME) $(SRC)

build: build-windows build-linux


run:
	./$(APP_NAME)

clean:
	rm -f $(OUTPUT_DIR)/$(APP_NAME) $(OUTPUT_DIR)/$(APP_NAME).exe


.PHONY: build-windows build-linux build run clean