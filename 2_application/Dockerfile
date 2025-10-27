# build stage
FROM golang:1.20 AS builder
WORKDIR /src
COPY app/go.mod app/go.sum ./
RUN go mod download
COPY app/ .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go-server .

# runtime
FROM gcr.io/distroless/static
COPY --from=builder /go-server /go-server
EXPOSE 8080
ENTRYPOINT ["/go-server"]
