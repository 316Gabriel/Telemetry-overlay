import sys
from datetime import datetime, timedelta

def parse_time(time_str):
    """Convertit une chaîne de caractères au format HH:MM:SS en objet datetime.time."""
    try:
        return datetime.strptime(time_str, '%H:%M:%S').time()
    except ValueError:
        raise ValueError(f"Le format de l'heure {time_str} est incorrect. Utilisez le format HH:MM:SS.")

def time_difference(start_time, start_time1):
    """Calcule la différence entre deux objets datetime.time."""
    # Convertir les objets time en objets datetime pour faire la soustraction
    today = datetime.today().date()
    datetime_start = datetime.combine(today, start_time)
    datetime_start1 = datetime.combine(today, start_time1)

    # Calculer la différence
    time_diff = datetime_start1 - datetime_start

    # S'assurer que la différence est positive en utilisant abs
    time_diff = abs(time_diff)

    return time_diff

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 time_diff.py <start_time> <start_time1>")
        sys.exit(1)

    start_time_str = sys.argv[1]
    start_time1_str = sys.argv[2]

    # Convertir les chaînes de caractères en objets datetime.time
    try:
        start_time = parse_time(start_time_str)
        start_time1 = parse_time(start_time1_str)
    except ValueError as e:
        print(e)
        sys.exit(1)

    # Calculer la différence de temps
    trueStartTime = time_difference(start_time, start_time1)

    # Afficher le résultat
    print(trueStartTime)

if __name__ == "__main__":
    main()
