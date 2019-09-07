# Start by building the application.
FROM golang:1.13 as build

WORKDIR /go/src/app
COPY main.go /go/src/app/

RUN go get -d -v ./...
RUN go build -o /go/bin/app

# Now copy it into our base image.
FROM gcr.io/distroless/base:nonroot
COPY --from=build /go/bin/app /
COPY index.html /
CMD ["/app"]
