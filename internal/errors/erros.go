package errors

import "errors"

var (
	ErrPathNotFound = errors.New("specified path not found in s3")
)
