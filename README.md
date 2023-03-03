# Projet_IA : Identification d’ensembles  de gènes par  programmation logique

Ce repository contient les codes pour identifier les gènes à partir de matrices de cellules et de gènes en utilisant l'ASP (Answer Set Programming).
## Contenu du repository
Le repository est organisé en trois dossiers :
- `algorithmes`: contient les algorithmes ASP et le fichier python
- `données` : contient les matrices transformées en atomes à utiliser avec les algorithmes ASP
- `matrices` : contient les matrices de cellules et de gènes
- `résultats` : contient des résultats obtenus
## Pour exécuter le code
Pour exécuter les algorithmes ASP, on utilise la commande : clingo algorithmes/nom_algo 

On peut rajouter des arguments dans la ligne de commande :
- `-t n` : pour utiliser le multithreading avec n threads (n<64)
- `--time-limit=n` : pour limiter le temps d'exécution de l'algorithme à n secondes
- `0 --project --opt-mod=enum,n` : pour faire une projection avec pour valeur d'optimisation n