  # Installation gopro dashboard sur PC


## Installation des prés-requis de Gopro Dashboard:
-Linux
-Python3.10
-ffmpeg
-libraqm 

### Se placer dans son home dir dans le terminal Linux:
```sh
cd
```
### Vérification de la version de python dans le terminal Linux:
```sh
python3 -V
```

### Installation de la librairie ffmpeg


```shell
# Mise à jour des dépots
sudo apt-get update && sudo apt-get upgrade
# Installation ffmpeg
sudo apt-get  install ffmpeg
# Vérification que ffmpeg est installé
ffmpeg -version
```

### Installation  de la librairie libraqm

```sh
sudo apt-get install libraqm-dev
```

## Installation de pip pour python3
```sh
sudo apt-get install python3-pip
```

## Installation de gopro-dashboard
### Installation en environnement virtuel
```sh
sudo apt-get install python3.10-venv
python3 -m venv venv
```
### Installation gopro-overlay
```sh
venv/bin/pip install gopro-overlay
```

### Installation des compléments
```sh
sudo apt-get install pacman
sudo apt-get install fonts-roboto
#sudo apt-get install truetype-roboto
sudo apt-get install libcairo2-dev
venv/bin/pip install pycairo==1.23.0
```


### Ajout alias
```sh
# commande gopro dashboard
echo "alias gpdb='~/venv/bin/gopro-dashboard.py ' " >> ~/.bash_aliases
# repertoire contenant les rushs video
echo "# Variable d'environnement (à adapter en fonction de votre PC)" >> ~/.bash_aliases
echo "rushV='/mnt/d/Video/exportInsta360'" >> ~/.bash_aliases
```
Penser à fermer/re-ouvrir le terminal pour que les alias soient pris en compte


### Vérifications:
```sh
venv/bin/gopro-dashboard.py -h
```
### Aide :
    Gopro-overlay installation : https://github.com/time4tea/gopro-dashboard-overlay?tab=readme-ov-file
    Gopro-overlay commandes : https://github.com/time4tea/gopro-dashboard-overlay/tree/main/docs/bin
    Custom des dashboards : https://github.com/time4tea/gopro-dashboard-overlay/blob/main/docs/xml/examples/README.md    
    
## Création programme d'overlay

### Modification des ffmpeg profile pour ajouter un built-in profile("overlay")
Ajouter dans le fichier : ```~/venv/lib/python3.10/site-packages/gopro_overlay/ffmpeg_profile.py ```
la rubrique ligne 28:
```json
,
    "overlayPerso": {
        "input": [],
        "output": ["-vcodec", "png"]
    }
```

#### Génération d'une vidéo transparente avec juste l'overlay 
```sh
gpdb --use-gpx-only --gpx $rushV/testGaby/test_gaby.gpx --profile overlayPerso--overlay-size 1920x1080 $rushV/testGaby/test_gaby-outputOverlay.mov
```

Pour les vidéos Gopro:
```sh
gpdb $rushV/testGaby/GH011630.MP4 $rushV/testGaby/GH011630-dashboard.MP4
```
![alt text](image.png)


### Customisation du fichier XML d'overlay
#### Copie de fichiers d'exemple :
cp ~/venv/lib/python3.10/site-packages/gopro_overlay/layouts/default-1920x1080.xml ~/venv/lib/python3.10/site-packages/gopro_overlay/layouts/marche.xml
cp ~/venv/lib/python3.10/site-packages/gopro_overlay/layouts/default-1920x1080.xml ~/venv/lib/python3.10/site-packages/gopro_overlay/layouts/vol.xml

donc deux fichiers de layouts différents pour les vidéos de marche et pour les vidéos de vol (parapente) :
    marche.xml
    vol.xml
    
#### Modification du fichier vol.xml

nano ~/venv/lib/python3.10/site-packages/gopro_overlay/layouts/vol.xml

```xml
<layout>
    <composite x="16" y="30" name="date_and_time">
        <component type="datetime" x="0" y="24" format="Date : %d/%m/%Y" size="16" align="left"/>
        <component type="datetime" x="0" y="48" format="%H:%M:%S" size="32" align="left"/>
    </composite>

    <composite x="16" y="800" name="big_kph">
        <component type="metric_unit" metric="speed" units="kph" size="16">VITESSE(Km/h)</component>
        <component type="metric" x="0" y="0" metric="speed" units="kph" dp="0" size="160" />
    </composite>

    <component type="chart" name="gradient_chart" x="400" y="980"/>

    <composite x="16" y="980" name="altitude">
        <component type="metric_unit" x="70" y="0" metric="alt" units="alt" size="16">ALT({:~C})</component>
        <component type="icon" x="0" y="0" file="mountain.png" size="64"/>
        <component type="metric" x="70" y="18" metric="alt" units="alt" dp="0" size="32" />
    </composite>

    <composite x="1900" y="820" name="temperature">
        <component type="metric_unit" x="-70" y="0" size="16" align="right" metric="temp" units="temp">TEMP({:~C})</component>
        <component type="icon" x="-64" y="0" file="thermometer.png" size="64"/>
        <component type="metric" x="-70" y="18" dp="0" size="32" align="right" metric="temp" units="temp"/>
    </composite>

    <component type="moving_map" name="moving_map" x="1644" y="100" size="256" zoom="16" corner_radius="35"/>
    <component type="journey_map" name="journey_map" x="1644" y="376" size="256" corner_radius="35"/>
</layout>
```

Commande avec le layout personnalisé:
gpdb --layout-xml ~/venv/lib/python3.10/site-packages/gopro_overlay/layouts/vol.xml --use-gpx-only --gpx $rushV/testGaby/test_gaby.gpx --profile overlayPerso --overlay-size 1920x1080 $rushV/testGaby/test_gaby-outputOverlay_vol.mov

#### Ressources 
icones : https://www.flaticon.com/search/?word=sport

### Fusion de la vidéo de l'overlay avec la vidéo d'origine




# Exemple de bash pour executer les commandes en boucle

```shell
#!/bin/bash
currentDir=`pwd`
echo "Debut du super programme :"
for x in *.gpx; do 
  #echo "Le fichier : " $x " sera renommé avec ffmpeg =>" ${x%.gpx}"_ouput.mp4"; 
  echo "# /mnt/c/Users/Gabriel/Documents/2024_STAGE/venv/bin/gopro-dashboard.py --use-gpx-only --gpx ${currentDir}/${x} --profile overlay --overlay-size 1920x1080 "${x%.gpx}"_ouput.mp4";
 
done

echo "############# TEST #################"
# maVar="/mnt/c/Users/Gabriel/Documents/2024_STAGE/venv/bin/gopro-dashboard.py -h"
# ${maVar}
```

Resultat :
```shell
gaby@LORDI-VIGDEHLAI:/mnt/c/Users/Gabriel/Documents/2024_STAGE/data/sample2/gpx$ ./demo.sh 
Debut du super programme :
# /mnt/c/Users/Gabriel/Documents/2024_STAGE/venv/bin/gopro-dashboard.py --use-gpx-only --gpx /mnt/c/Users/Gabriel/Documents/2024_STAGE/data/sample2/gpx/combined_gpx_file.gpx --profile overlay --overlay-size 1920x1080 combined_gpx_file_ouput.mp4    
# /mnt/c/Users/Gabriel/Documents/2024_STAGE/venv/bin/gopro-dashboard.py --use-gpx-only --gpx /mnt/c/Users/Gabriel/Documents/2024_STAGE/data/sample2/gpx/montre.gpx --profile overlay --overlay-size 1920x1080 montre_ouput.mp4
# /mnt/c/Users/Gabriel/Documents/2024_STAGE/venv/bin/gopro-dashboard.py --use-gpx-only --gpx /mnt/c/Users/Gabriel/Documents/2024_STAGE/data/sample2/gpx/vario.gpx --profile overlay --overlay-size 1920x1080 vario_ouput.mp4
############# TEST #################
```


