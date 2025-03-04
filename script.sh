#!bin/bash

# aturar en el cas de que hi hagi algun error
set -e

# iniciem el servei de postgresql
service postgresql start

sleep 5

# canviem la contrasenya de l'usuari postgres
psql -U postgres -c "ALTER USER postgres WITH PASSWORD '${POSTGRES_DEFAULT_PASS}';" 

echo "Contrasenya de l'usuari postgres canviada";

# creem la base de dades
psql -U postgres -c "CREATE DATABASE videogames;"

# importam la base de dades
psql -U postgres -d videogames -f /home/backup/backup_videogames.sql

# crear usuari de postgresql
psql -U postgres -c "CREATE USER \"${POSTGRES_USER}\" WITH PASSWORD '${POSTGRES_PASSWORD}';"

# donam permisos a la base de dades
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE videogames TO \"${POSTGRES_USER}\";"

echo "✅ PostgreSQL configurat correctament!"


# descarregem el script per a la configuració de postgresql i la creació de la base de dades
WORKDIR /home/backup
RUN wget https://raw.githubusercontent.com/mamateu10/docker_postgresql/refs/heads/main/script.sh
# assignar permisos al fitxer
RUN chmod +x script.sh
# executam el script
RUN ./script.sh