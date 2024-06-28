# getInfoGPX.py
Le programme getInfoGPX.py permet d'obtenir la durée d'un fichier GPX(le temps) et l'heure du premier point du fichier GPX.
Les variables de sortie sont utilisables en shell ensuite. Il est utilisé avec le programme CutPourOverlayMap.sh. Pour l'utiliser, il suffit de taper la commande:
```sh
python3 getInfoGPX.py(leNomDuFichierGPX.gpx)
```

# TrueStartTime.py
Le programme permet de réaliser une différence de temps entre deux heures. Il est utilisé avec le programme CutPourOverlayMap.sh.
Il s'utilise avec la commande:
```sh
python3 TrueStartTime.py $start_time $start_time1
```
