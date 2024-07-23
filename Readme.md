# Projet tests
Important ! L'énonce laissant planner un doute sur le comportement des vies, j'ai décidé de l'implémenter de la manière suivante :
L'utilisateur à deux vies qu'il peut utiliser entièrement, il peut donc continuer à augmenter sa série même si il a perdu ses 2 vies. La série sera réinitialiser si il rate une journée alors qu'il avait 0 vie.

## Description
Cet exercice a été réalisé afin de tester un algorithme de calcul de série de répétition d'exercices de yoga. L'algorithme est implémenté en NodeJS et les tests sont réalisés en bash. L'algorithme a tournée sur le fichier csv fourni `data.csv` et a généré un fichier `output.csv` qui contient les résultats de la série de répétition.

## Lancements des tests
Pour lancer des tests, il y a 2 possibilités : 
- La première est d'installer docker[https://docs.docker.com/get-docker/] et de lancer la commande `docker-compose up` à la racine du projet.
- La deuxième est d'installer NodeJS[https://nodejs.org/en/download/] et de lancer la commande `npm install` dans le dossier `server` puis d'executer le fichier `main.sh` à la racine du projet.

## Output
Après avoir lancé la commande, les tests se lanceront automatiquement, affichant les résultats dans la console. Les résultats sont affichés sous forme de `✅` pour un test réussi et `❌` pour un test échoué. Tous les résultats sont disponibles dans le dossier `out` qui contient pour chaque test un dossier `in.log` et `out.log` qui contiennent respectivement les résultats attendus et les résultats obtenus.

## Liste des tests
Les tests nécessaires ont été trouvé grace au graphique créé à partir de l'énoncé. Ce graphique est présent à la racine du projet sous le nom de `graph.png`. Les tests sont au nombre de 15 et sont les suivants : 

| Number | Name                                            |    |
|--------|-------------------------------------------------|----|
| #1     | Nothing                                         | ✅ |
| #2     | One exercise level 2                            | ✅ |
| #3     | One exercise complete                           | ✅ |
| #4     | All level 1 and all level 2                     | ✅ |
| #5     | All level 1 and all level 1                     | ✅ |
| #6     | One level 1 and all level 2                     | ✅ |
| #7     | One level 1 and same level 1                    | ✅ |
| #8     | All level 1 and both level 1                    | ✅ |
| #9     | All level 2                                     | ✅ |
| #10    | Has score, no exercise, has life                | ✅ |
| #11    | Has score, no exercise, no life                 | ✅ |
| #12    | Has score, has practice, has two lives          | ✅ |
| #13    | Has score, has practice, has one life           | ✅ |
| #14    | Has score, has practice, has one life, get life | ✅ |
| #15    | Lives do not exceed 2                           | ✅ |
| #16    | Skip days, lose lives, reset score              | ✅ |


### Test #1
Ne valide aucun exercice, la série n'augmente pas.

### Test #2
Ne fais qu'un exercice level 2, la série n'augmente pas.

### Test #3
Fais un exercice level 1, puis le même level 1, la série n'augmente pas.

### Test #4
Fais tous les exercices level 1 et tous les exercices level 2, la série augmente.

### Test #5
Fais tous les exercices level 1, puis tous les exercices level 1, la série augmente.

### Test #6
Fais un exercice level 1, puis tous les exercices level 2, la série augmente.

### Test #7
Fais tous les exercices level 1, puis un seul level 1, la série n'augmente pas.

### Test #8
Fais tous les exercices level 1, puis un exercice de chaque level 1, la série augmente.

### Test #9
Fais tous les exercices level 2, la série augmente.

### Test #10
A déjà un score, ne finis pas les exercices un jour et perd une vie, la série n'augmente pas, puis finis un exercice, la série augmente, puis ne fais plus rien et tout est reset.

### Test #11
A déjà un score, n'a plus de vie, fini un exercice, la série augmente, puis ne fais plus rien et tout est reset.

### Test #12
A déjà un score et 2 vies, perds toutes ses vies car ne fini pas les exercices, le score est reset, la série n'augmente pas.

### Test #13
A déjà un score et 1 vie, fini un exercice, la série augmente, puis ne fais plus rien et tout est reset.

### Test #14
A déjà un score et 1 vie, fini un exercice 5 jours de suite, la série augmente et il gagne une vie, puis ne fais plus rien et tout est reset après avoir perdu ses deux vies.

### Test #15
Réussi 5 jours de suite avec déjà 2 vies, la série augmente, mais ne gagne pas de vie, puis ne fais plus rien et tout est reset après avoir perdu ses deux vies.

### Test #16
À déjà un score, ne fais rien du tout pendant 2 jours, la série n'augmente pas et il perd ses deux vies, puis fini un exercice, la série augmente, puis skip une journée son score est reset et il n'aura qu'un score pour la journée finie.