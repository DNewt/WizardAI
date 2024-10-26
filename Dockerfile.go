FROM golang:1.23.2

WORKDIR /gotest

COPY ./wizardai_aws_s3_bucket /gotest

RUN apt-get update && apt-get install -y unzip curl

RUN curl -fsSL -o terraform_1.9.7_linux_amd64.zip https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_amd64.zip && \
    unzip terraform_1.9.7_linux_amd64.zip -d /usr/local/bin && \
    rm terraform_1.9.7_linux_amd64.zip

RUN go mod init wizardai_aws_s3_bucket_test && \
    go get github.com/gruntwork-io/terratest/modules/aws \
    github.com/gruntwork-io/terratest/modules/terraform \
    github.com/stretchr/testify/assert \
    github.com/gruntwork-io/terratest/modules/random && \
    go mod tidy

CMD ["go", "test", "-v", "./test/..."]