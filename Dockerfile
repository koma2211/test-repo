FROM golang:alpine as stage1
WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY ./ ./

RUN go build -o main main.go

FROM scratch
WORKDIR /

COPY --from=stage1 /app/main main

EXPOSE 8085

CMD [ "/main" ]