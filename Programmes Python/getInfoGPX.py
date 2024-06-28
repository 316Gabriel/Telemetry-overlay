import gpxpy
import gpxpy.gpx
from datetime import datetime
import argparse

def read_gpx(file_path):
    with open(file_path, 'r') as gpx_file:
        gpx = gpxpy.parse(gpx_file)

        # Obtenir tous les points de trace
        all_points = []
        for track in gpx.tracks:
            for segment in track.segments:
                for point in segment.points:
                    all_points.append(point)

        if not all_points:
            raise ValueError("Le fichier GPX ne contient pas de points de trace.")

        # Heure du premier point
        start_time = all_points[0].time

        # Heure du dernier point
        end_time = all_points[-1].time

        if start_time is None or end_time is None:
            raise ValueError("Certains points de trace n'ont pas d'information de temps.")

        # Calcul de la durée entre le premier et le dernier point
        duration = end_time - start_time

        return start_time, duration

def main():
    parser = argparse.ArgumentParser(description='Lire un fichier GPX et retourner la durée entre le premier et le dernier point ainsi que l\'heure du premier point.')
    parser.add_argument('file_path', type=str, help='Le chemin du fichier GPX')

    args = parser.parse_args()

    start_time, duration = read_gpx(args.file_path)
    #print(f"Heure du premier point : {start_time}")
    #print(f"Durée entre le premier et le dernier point : {duration}")
    print(start_time)
    print(duration)

if __name__ == "__main__":
    main()
