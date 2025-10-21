# ARG url 
#ARG fonctionne uniquement au build de l'image donc pas a chaque run meme si on lance le run avec en parametre l'url ca fera rien
FROM alpine
#alpine c une distribution linux minimaliste (dinc bien pour docker) => rapide 

RUN adduser -D non_root_user
#création user (-D crée un user sans mdp p/defaut)

RUN apk update && apk add curl 
#apk c le gestionnaire de paquet sur alpine 
#on doit toujours mettre à jour les "index des paquets" avec apk update avant d'installer des paquets. C comme pour refaire un "inventaire" des paquets et où les toruver pour ensuite aller les chercher 
#apk add c pour installer le paquet curl  

USER non_root_user
# a partir de cette commande ce qui s'execute s'execute avec le user en question et non plus en root. (c pour ça que on met ca après l'install des paquets sinon nouvel_user n'a pas les droits pour installer des paquets)

# CMD [ "curl" ] 
#pas besoin de mettre les arg ici prcq quand on va lancer le conteneur avec run il va lancer curl et ce qui suit dans la commande donc l'url. 

ENTRYPOINT [ "curl" ]
# il faut utiliser entrypoint ici pour que les arg soient utilisés sinon avec CMD les arg remplaceent carrément ce qui a dans le CMD je crois 

# commande pour build le container : docker build -t my_container -f le_dockerfile .
#                       => t pour tag (nom du container) -f pour spécifier le dockerfile (si il ne s'appelle pas Dockerfile il faut sépcifier) et le . c pour dire que c dans le repertoire courant (surtout si y a des COPY ou ADD)

#command pour run : docker run --rm my_container <url> 
# rm pour supp après l'utilisation du container 