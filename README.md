# Projet IA : Identification d’ensembles  de gènes par  programmation logique

Ce repository contient les codes pour identifier les gènes à partir de matrices de cellules et de gènes en utilisant l'ASP (Answer Set Programming).
## Contenu du repository
Le repository est organisé en trois dossiers :
- `algorithmes`: contient les algorithmes ASP et le fichier python
- `données` : contient les matrices transformées en atomes à utiliser avec les algorithmes ASP
- `matrices` : contient les matrices de cellules et de gènes
- `résultats` : contient des résultats obtenus
## Pour exécuter le code
Pour exécuter le code python :
```
python3 algorithmes/atome.py
```
Pour exécuter les algorithmes ASP : 
```
clingo algorithmes/nom_algo
```

On peut rajouter des arguments dans la ligne de commande ASP :
- `0 --project --opt-mod=enum,n` : pour faire une projection avec pour valeur d'optimisation n
- `--time-limit=n` : pour limiter le temps d'exécution de l'algorithme à n secondes
- `-t n` : pour utiliser le multithreading avec n threads (n<64)