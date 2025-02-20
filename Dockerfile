# Build stage

FROM golang:1.23.2-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -v hiurachat

# Run stage

FROM alpine:latest

WORKDIR /root

COPY --from=builder /app/hiurachat .

CMD ["./hiurachat"]
