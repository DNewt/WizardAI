package test

import (
	"os"
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/gruntwork-io/terratest/modules/random"
)

func TestWizardAIS3BucketModule(t *testing.T) {
	t.Parallel()

	loggingBucket := os.Getenv("LOGGING_BUCKET_NAME")
	kmsKeyID := os.Getenv("KMS_KEY_ID")

	if loggingBucket == "" || kmsKeyID == "" {
		t.Fatal("Both LOGGING_BUCKET_NAME and KMS_KEY_ID env vars must be set")
	}

	uniqueID := random.Random(1, 10000)

	expectedBucketName := fmt.Sprintf("test-s3-%d", uniqueID)
	awsRegion := "ap-southeast-2"

	terraformOptions := &terraform.Options{
		TerraformDir: "../",

		Vars: map[string]interface{}{
			"bucket_name":    expectedBucketName,
			"environment":    "development",
			"kms_key_id":     kmsKeyID,
			"team_name":      "WizardAIDevOps",
			"team_email":     "devops@example.com",
			"logging_bucket_name": loggingBucket,
		},

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	bucketName := terraform.Output(t, terraformOptions, "bucket_id")

	// Validate the bucket is created
	aws.AssertS3BucketExists(t, awsRegion, bucketName)
	
	// Validate the bucket has the correct tags
    actualTags := aws.GetS3BucketTags(t, awsRegion, bucketName)

    // Verify each expected tag exists in the actual tags
	assert.Equal(t, actualTags["Name"], bucketName)
	assert.Equal(t, actualTags["Environment"], "development")
	assert.Equal(t, actualTags["TeamName"], "WizardAIDevOps")
	assert.Equal(t, actualTags["TeamEmail"], "devops@example.com")

	// Validate the bucket has versioning enabled
	aws.AssertS3BucketVersioningExists(t, awsRegion, bucketName)

	// Validate the bucket at least has some policies
	aws.AssertS3BucketPolicyExists(t, awsRegion, bucketName)

	// Validate the logging bucket is the target bucket for the bucket
	logging_target := aws.GetS3BucketLoggingTarget(t, awsRegion, bucketName)
	assert.Equal(t, logging_target, loggingBucket)

}