#!/bin/bash

# paramétres du script
## rep de traitement où sont les videos
repTraitement=" /mnt/c/Users/Gabriel/Documents/2024_Stage/data/sample4"
## prefixe des noms des fichiers gpx
gpxPrefixe="veloGaby_part"
## alias de la commande
gpdb='/mnt/c/Users/Gabriel/Documents/2024_Stage/venv/bin/gopro-dashboard.py '
## params de la commande
layoutFile='/mnt/c/Users/Gabriel/Documents/2024_Stage/venv/lib/python3.10/site-packages/gopro_overlay/layouts/LayoutPerso-1920x1080.xml'
options="--layout-xml $layoutFile --use-gpx-only --overlay-size 1920x1080 --profile overlay "

# traitement :
repDep=`pwd`
cd $repTraitement
echo "Traitement des fichiers suivants en lot :"
for x in ${gpxPrefixe}*.gpx; do 
  # Tada!
  echo " - Fichier : " $x  "=>" $repTraitement/$(basename $x .${x##*.})_Overlay.mov
  
  # Creation de l'overlay en format mov
  $gpdb $options --gpx $repTraitement/$x $repTraitement/$(basename $x .${x##*.})_Overlay.mov 2>&1 > $repTraitement/goproDashBoard.log

  # Change le format de la video overlay mov => mp4
  ffmpeg -i $repTraitement/$(basename $x .${x##*.})_Overlay.mov $repTraitement/$(basename $x .${x##*.})_Overlay.mp4 2>&1 > $repTraitement/ffmpeg.log

  # suppression de l'overlay intermediaire (mov)
  rm $repTraitement/$(basename $x .${x##*.})_Overlay.mov
done

# retour rep de départ
cd $repDep
