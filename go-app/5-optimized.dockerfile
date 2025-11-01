FROM golang:1.21 AS builder 

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o server .
#ici on compile en statique c a d que aucune dependance system prcq sinon sans ca golan:1.21 est basé sur debian donc lié à des bibilio libc alors que Alpine utilise musl au lieu de glibc donc ca plante 

FROM alpine

RUN adduser --disabled-password non_root_user

WORKDIR /app

#on repart d'une image hyper légère
#quand on démarres un nouveau stage, le précédent "n'existe plus", il est commme surchargé donc on peut utiliser ce qu'il a mis en place mais il va plus etre le stage qu'on utilise
#on peut utiliser le conten udu stage pré&cédent en explicitant COPY --from=builder ... 

COPY --from=builder /app/server /app/server 
# la on copie le binaire server qui a été compilé avec le run go build -o server . du workdir ou il était, dans /server notre nouveau workdir 

EXPOSE 8080

USER non_root_user

CMD ["/app/server"]