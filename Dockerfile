
# to make image = docker build -t go-api-image .
# to view image after success = docker images
# to view container = docker ps -a
# to run app = docker run --rm -p 3000:3000 go-api-image
# to see in browser = http://localhost:3000

# to delete images
# docker rmi -f $(docker images -a -q)
# to delete containers
# docker rm -vf $(docker ps -a -q)


#go env -> GOOS = "windows"
# in cmd admin
# set GOOS=linux
# set GOOS=windows

FROM golang:1.12.7-alpine3.10
RUN apk add git
RUN mkdir /app 
ADD . /app
WORKDIR /app 
RUN go get github.com/go-chi/chi
RUN go build -o main .
EXPOSE 3000
CMD ["/app/main"]

# FROM golang:1.12 

# ADD . /go-app
# WORKDIR /go-api

# RUN go get github.com/go-chi/chi

# # Expose the application on port 8080
# EXPOSE 8080

# # Set the entry point of the container to the bee command that runs the
# # application and watches for changes
# CMD ["go-api", "main.go"]

