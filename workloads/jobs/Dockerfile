# Stage 1: The "builder" stage, where we compile the Go application.
# Using a specific, stable version of Go is a best practice. 1.22 is current.
FROM golang:1.22-alpine AS builder

# Set the working directory inside the container.
WORKDIR /app

# Copy the source code into the container.
COPY data-processing.go .

# Initialize a Go module. This is a best practice for all Go projects.
RUN go mod init data-processor
RUN go mod tidy

# Build a statically-linked binary. This is crucial for minimal images like distroless or scratch.
# CGO_ENABLED=0 disables Cgo, creating a pure Go binary.
# The output is named 'data-processor' and placed in the current directory (/app).
RUN CGO_ENABLED=0 go build -o data-processor .

# Stage 2: The final, minimal image.
FROM gcr.io/distroless/static-debian12
COPY --from=builder /app/data-processor /data-processor
CMD ["/data-processor"]