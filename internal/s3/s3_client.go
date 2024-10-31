package s3

import (
	"bucket-explorer/internal/errors"
	"context"
	"log"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

const bucketName = "test-bucket-rakesh11"

func ListBucketContent(path string) ([]string, error) {
	cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion("us-west-2"))
	if err != nil {
		log.Printf("Failed to load AWS config: %v", err)
		return nil, err
	}

	svc := s3.NewFromConfig(cfg)
	input := &s3.ListObjectsV2Input{
		Bucket: aws.String(bucketName),
		Prefix: aws.String(path),
	}

	result, err := svc.ListObjectsV2(context.TODO(), input)
	if err != nil {
		log.Printf("Failed to list objects from bucket %s: %v", bucketName, err)
		return nil, err
	}

	contents := []string{}

	if len(result.Contents) == 0 {
		log.Printf("No contents found for path: %s", path)
		return nil, errors.ErrPathNotFound
	}
	for _, item := range result.Contents {
		key := *item.Key
		if path == "" {
			if len(key) > 0 && key != "/" {
				parts := strings.Split(key, "/")
				if !contains(contents, parts[0]) && parts[0] != "" {
					log.Printf("Found directory: %s", parts[0])
					contents = append(contents, parts[0])
				}
			}
		} else {
			if strings.HasPrefix(key, path) && len(key) > len(path) {
				subPath := key[len(path):]
				if trimmed := strings.TrimPrefix(subPath, "/"); trimmed != "" {
					contents = append(contents, trimmed)
				}
			}
		}
	}

	return contents, nil
}

func contains(slice []string, item string) bool {
	for _, v := range slice {
		if v == item {
			return true
		}
	}

	return false
}
