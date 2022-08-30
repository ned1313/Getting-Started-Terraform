package test

// to run in terminal:
/*
go env -w GO111MODULE=auto
go mod init test.go/packages
go mod tidy
go test -v .\webserver_test.go
//*/
import (
	"fmt"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
	"time"
)

func TestTerraformWebserverExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// location of terraform project
		TerraformDir: "../",
	})

	//terminal commands
	terraform.InitAndApply(t, terraformOptions)
	defer terraform.Destroy(t, terraformOptions)

	//verify website is up and running
	value := terraform.Output(t, terraformOptions, "value")

	url := fmt.Sprintf("http://%s:8080", value)
	//http_helper.HttpGetWithRetry(t, url, nil, [HTTP status code], [return val expected], [retry attempts], [time to wait between each retry])
	http_helper.HttpGetWithRetry(t, url, nil, 200, "I made a terraform module!", 30, 5*time.Second)

}
