FROM alpine AS my-echo-builder
RUN apk add --no-cache bash
RUN echo '#!/bin/bash' > /myecho && \
    echo 'echo "Hello, World!"' >> /myecho && \
    chmod +x /myecho

FROM golang:latest as go-builder

WORKDIR /app

RUN go mod init module-main

RUN go mod download

COPY *.go .

RUN go build -o hello-go

FROM scratch

WORKDIR /app

COPY --from=go-builder /app .
COPY --from=my-echo-builder /myecho .

CMD [ "myecho", "Full Cycle Rocks!!" ]
