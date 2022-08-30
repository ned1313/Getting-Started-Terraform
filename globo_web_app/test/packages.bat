(go env -w GO111MODULE=auto && go mod init test.go/packages && go mod tidy) || (go mod tidy && .\test.bat)
