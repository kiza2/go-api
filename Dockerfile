
# to make image = docker build -t go-api-image .
# to view image after success = docker images
# to view container = docker ps -a
# to run app = docker run --rm -d -p 3000:3000 go-api-image
#  docker run --rm p 3000:3000 go-api-image (waiting..., no return to prompt)
# to see in browser = http://localhost:3000

# to delete images
# docker rmi -f $(docker images -a -q)
# to delete containers
# docker rm -vf $(docker ps -a -q)

# DELETE ALL
# docker system prune -a


#go env -> GOOS = "windows"
# in cmd admin
# set GOOS=linux
# set GOOS=windows

# regular way = 387 MB
# multi-state = 13.3 MB
# scratch = 7.6 MB
# Multistage build to make a temporary container to help the app build
# then copy assets to another container with least amt of components to run app
FROM golang:alpine as builder
#RUN apk add git
# alpine doesn't have some apps, so adding git, bash, and openssh to the image
#RUN apk update && apk upgrade && apk add --no-cache bash git openssh
RUN apk update && apk upgrade && apk add --no-cache git
LABEL maintainer="Alex Yu"

RUN mkdir /build 
ADD . /build
WORKDIR /build 
COPY go.mod go.sum ./

# download all dependencies
RUN  go mod download

# copy all files here to current working dir (/build)
COPY . .

#RUN CGO_ENABLED=0 GOOS=linux go get -a -installsuffix cgo -ldflags '-extldflags "-static"'  github.com/go-chi/chi
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .

# start over
FROM scratch


#RUN go build -o main .

# very very lightweight
#FROM alpine
#RUN adduser -S -D -H -h /app appuser
#USER appuser
# copy just executable w/ no container OS
COPY --from=builder /build/main /app/
WORKDIR /app
EXPOSE 3000
CMD ["./main"]
