#!bin/bash

# iniciem el servei de postgresql
service postgresql start

# canviem la contrasenya de l'usuari postgres
psql -U postgres -c "ALTER USER postgres WITH PASSWORD '${POSTGRES_DEFAULT_PASS}';" 
# creem la base de dades
psql -U postgres -c "CREATE DATABASE videogames;" && \
# importam la base de dades
psql -U postgres -d videogames -f /home/backup/backup_videogames.sql && \
# crear usuari de postgresql
psql -U postgres -c "CREATE USER \"${POSTGRES_USER}\" WITH PASSWORD '${POSTGRES_PASSWORD}';" && \
# donam permisos a la base de dades
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE videogames TO \"${POSTGRES_USER}\";"



# descarregem el script per a la configuració de postgresql i la creació de la base de dades
RUN wget https://raw.githubusercontent.com/mamateu10/docker_postgresql/refs/heads/main/script.sh
# assignar permisos al fitxer
RUN chmod +x script.sh
# executam el script
RUN ./script.sh