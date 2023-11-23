FROM golang:latest as go-builder

WORKDIR /app

RUN go mod init module-main

RUN go mod download

COPY *.go .

RUN go build -o /app/hello-go

FROM scratch

WORKDIR /app

COPY --from=go-builder /app/hello-go .

ENTRYPOINT ["/app/hello-go"]