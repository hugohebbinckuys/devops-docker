#!/bin/bash
set -e  # arrête le script si une commande échoue

mkdir -p docker_bdd
cd docker_bdd

# créartion docker-compose.yml
cat <<EOF > docker-compose.yml

services:
  db:
    image: postgres:15
    container_name: testdb_container
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: test_u
      POSTGRES_PASSWORD: test_p
      POSTGRES_DB: testdb
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./bdd.sql:/docker-entrypoint-initdb.d/bdd.sql

volumes:
  pgdata:
EOF

# fichier SQL d'init
cat <<EOF > bdd.sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    stock INT DEFAULT 0
);

INSERT INTO users(username, email) VALUES ('hugo', 'hugo@gmail.com');

EOF

#Lancer le conteneur 
docker compose up -d

echo "containrr started" 
