FROM node:20

RUN adduser --disabled-password non_root
#-disabled-pass pour pas de mdp p/def

WORKDIR /app 

COPY broken-app/package.json .
#copier le package.json dans le reperotire courant (/app)

COPY broken-app . 

RUN npm install 
#installer les dep

EXPOSE 3000

USER non_root

CMD [ "node", "server.js" ]