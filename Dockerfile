# syntax=docker/dockerfile:1.4

FROM --platform=linux/amd64 golang:1.21 as builder

WORKDIR /workspace

COPY go.mod go.mod
COPY go.sum go.sum

RUN go mod download

COPY cmd/ cmd/
COPY apis/ apis/
COPY internal/ internal/
COPY config/ config/

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o provider cmd/provider/main.go

FROM alpine:3.7
WORKDIR /
COPY --from=builder /workspace/provider .
COPY package /

EXPOSE 8080
ENTRYPOINT ["/provider"]