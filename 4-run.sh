#!/bin/bash

docker build -t exo_4_image -f broken-app/4-dev-app.dockerfile .
# pas oublier le . sinon le conteneur ne sait pas ou trouver le dockerfile 

docker run --rm --name exo_4_container -p 3000:3000 -d exo_3_image 

#le -p pour -publish sert a faire de la redirection de port 
#indispensable l'option -p pour pouvoir dire : tout ce qui arrive sur le port 3000 de ma machine donc localhost:3000 je le renvoie vers le port 3000 du conteneur => -p 3000:3000