FROM golang:1.21 as builder
WORKDIR /app
COPY . .
RUN go build -o app .

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/app .
EXPOSE 4000
CMD ["./app"]
