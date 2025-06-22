# Tahap pertama: build aplikasi Go
FROM golang:1.24 as builder

WORKDIR /app
COPY . .

RUN go build -o app .

# Tahap kedua: runtime container
FROM debian:bookworm-slim

WORKDIR /app
COPY --from=builder /app/app .

CMD ["./app"]
