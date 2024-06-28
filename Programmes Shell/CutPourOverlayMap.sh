#!/bin/bash

# paramétres du script
## rep de traitement où sont les videos
repTraitement=" /mnt/c/Users/Gabriel/Documents/2024_Stage/data/sample4"
## prefixe des noms des fichiers gpx
gpxPrefixe="veloGaby_part"
## params de la commande
mapFile=" /mnt/c/Users/Gabriel/Documents/2024_Stage/data/sample4/velodashboard.MP4"

# traitement :
repDep=`pwd`
cd $repTraitement
# lecture des info pour le fichier gpx total
 python3 /mnt/c/Users/Gabriel/Documents/2024_STAGE/prog/python/getInfoGPX.py ./
 # Exécuter le script Python et capturer les sorties
output=$(python3 /mnt/c/Users/Gabriel/Documents/2024_STAGE/prog/python/getInfoGPX.py ./velodashboar.gpx)

# Utiliser `read` pour diviser la sortie en deux variables
read -r start_time1 duration <<< "$output"

# Afficher les résultats
echo "Heure du premier point : $start_time1"
echo "Durée entre le premier et le dernier point : $duration"


for x in ${gpxPrefixe}*.gpx; do 
  options="ffmpeg -i $mapFile -ss ($start_time - $start_time1) -codec copy -t $duration $repTraitement/$(basename $x .${x##*.})_Map.MP4"
  python3 /mnt/c/Users/Gabriel/Documents/2024_STAGE/prog/python/getInfoGPX.py ./$x
  read -r start_time duration <<< "$output" 
  $options
done

# retour rep de départ
cd $repDep
