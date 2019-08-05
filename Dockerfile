# to make image = docker build -t go-api-image .
# to view image after success = docker images
# to run app = docker run -it -d go-api-image
# to run app = docker run -publish 3000:3000 -name go-api-image
# to see in browser = http://localhost:3000


FROM golang:1.12
RUN mkdir /app 
ADD . /app/
WORKDIR /app 
RUN go get github.com/go-chi/chi
RUN go build -o main .
EXPOSE 3000
CMD ["./main"]

# FROM golang:1.12 

# ADD . /go-app
# WORKDIR /go-api

# RUN go get github.com/go-chi/chi

# # Expose the application on port 8080
# EXPOSE 8080

# # Set the entry point of the container to the bee command that runs the
# # application and watches for changes
# CMD ["go-api", "main.go"]

