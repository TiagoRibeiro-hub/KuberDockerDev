#multi stage build
#image golang
FROM golang:1.7.3 as build
WORKDIR /app
COPY main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main

#running in alpine image
FROM alpine:3.14 as final
WORKDIR /app
COPY --from=build /app/main .

CMD ["./main"]