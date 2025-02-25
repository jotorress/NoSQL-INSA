# Interroger des Bases de Données Non-Relationnelles

Ce répertoire contient les fichiers et solutions pour le TD des Bases de Données Non-Relationnelles.

**Fait par : CHICA Miller et TORRES Jonathan**

## Structure du répertoire

- **Exercice 1.1** : `abc.xml`
- **Exercice 1.2** : `recettes1.xml`, `recettes1.dtd`, `recettes2.xml`, `recettes2.dtd`
- **Exercice 1.3** : `iTunes-Music-Library.xml`
- **Exercice 2** : `stats.sql`
 
## Exercices

### Exercice 1.1 : Premiers pas

#### 1. `//e/preceding::text()`
Cette requête utilise `//e` pour localiser le nœud `<e>` dans le fichier. Ensuite, `preceding::text()` permet de récupérer tous les nœuds de texte précédant cet élément, y compris ceux présents dans les nœuds `<c>` et `<b>`. Cela inclut le texte `bli` s'il est présent avant `<e>`.

Commande :

```bash
xmllint --xpath "//e/preceding::text()" abc.xml
```

**Résultat :** `bli`

#### 2. `count(//c|//b/node())`
Cette requête compte tous les éléments `<c>` ainsi que tous les nœuds enfants de `<b>`, y compris les éléments et les nœuds de texte. Si un nœud `<c>` est déjà compté, il ne sera pas re-compté dans les enfants de `<b>`.

Commande :

```bash
xmllint --xpath "count(//c|//b/node())" abc.xml
```

**Résultat :** `4`

#### 3. La somme de tous les attributs

Commande :

```bash
xmllint --xpath "sum(//@*)" abc.xml
```

**Résultat :** `10`

#### 4. Le contenu textuel du document, où chaque `b` est remplacé par un `c`
La fonction `string(/)` extrait la valeur textuelle du document en concaténant tous les nœuds de texte. La fonction `translate()` remplace chaque occurrence de `b` par `c`.

Commande :

```bash
xmllint --xpath "translate(string(/),'b','c')" abc.xml
```

**Résultat :** `cliclacou`

#### 5. Le nom du fils du dernier élément `<c>` dans l’arbre

Commande :

```bash
xmllint --xpath "name(//c[last()]/*)" abc.xml
```

**Résultat :** `e`

### Effet de l’indentation sur les résultats

#### 1. `//e/preceding::text()`
XPath traite les espaces et les sauts de ligne comme des nœuds de texte vides. Ainsi, le résultat est identique mais inclut des espaces supplémentaires :

```
bli
```

#### 2. `count(//c|//b/node())`
Le résultat devient `8` en raison des nœuds de texte vides générés par l'indentation. On peut vérifier cela avec :

```bash
xmllint --shell abc.xml
/ > xpath //c|//b/node()
```

**Sortie :**
```bash
Object is a Node Set :
Set contains 8 nodes:
1  TEXT
    content=
2  ELEMENT c
3  TEXT
    content=
4  TEXT
    content= bli
5  ELEMENT c
6  TEXT
    content=
7  ELEMENT c
8  TEXT
    content=
/ >
```

#### 3. La somme de tous les attributs
Le résultat reste `10`, car les nœuds de texte vides ne contiennent pas d'attributs et ne sont donc pas pris en compte.

#### 4. Le contenu textuel avec remplacement de `b` par `c`
Le résultat contient des espaces supplémentaires dus à l'indentation :

```


cli


cla


cou


```

#### 5. Le nom du fils du dernier élément `<c>` dans l’arbre
Le résultat reste `e`, car l'indentation et les espaces n'affectent pas les requêtes cherchant les noms d'éléments.

---


### Exercice 1.2 - Recettes

Dans cet exercice, nous analysons deux DTD différentes permettant de décrire des recettes de cuisine. Nous utilisons XPath pour extraire des informations pertinentes de ces documents.

---

#### Recettes 1

##### 1. Extraction des titres des recettes
Nous extrayons les titres des recettes en naviguant à travers la structure XML :
```bash
xmllint --xpath "//recette/titre" recettes1.xml
```

##### 2. Extraction des noms des ingrédients
Les noms des ingrédients sont contenus dans l'élément `ingredient` :
```bash
xmllint --xpath "//ingredient/nom_ing" recettes1.xml
```

##### 3. Extraction du titre de la deuxième recette
On utilise un indice pour sélectionner la deuxième recette :
```bash
xmllint --xpath "//recette[2]/titre" recettes1.xml
```

##### 4. Extraction de la dernière étape de chaque recette
On utilise la fonction `[last()]` pour sélectionner la dernière étape :
```bash
xmllint --xpath "//texte/etape[last()]" recettes1.xml
```

##### 5. Comptage du nombre total de recettes
On compte le nombre de nœuds `recette` :
```bash
xmllint --xpath "count(//recette)" recettes1.xml
```

##### 6. Sélection des recettes avec strictement moins de 7 ingrédients
On utilise `count()` pour filtrer les recettes ayant moins de 7 ingrédients :
```bash
xmllint --xpath "//recette[count(ingredients/ingredient) < 7]" recettes1.xml
```

##### 7. Extraction des titres des recettes avec strictement moins de 7 ingrédients
On applique le filtre précédent en extrayant uniquement les titres :
```bash
xmllint --xpath "//recette[count(ingredients/ingredient) < 7]/titre" recettes1.xml
```

##### 8. Extraction des recettes contenant de la farine
On filtre les recettes contenant l'ingrédient `farine` :
```bash
xmllint --xpath "//recette[ingredients/ingredient/nom_ing = 'farine']" recettes1.xml
```

##### 9. Extraction des recettes de la catégorie "entrée"
On sélectionne les recettes appartenant à la catégorie "Entrée" :
```bash
xmllint --xpath "//recette[categorie = 'Entrée']" recettes1.xml
```

---

#### Recettes 2

##### 1. Extraction des titres des recettes
```bash
xmllint --xpath "//recette/titre" recettes2.xml
```

##### 2. Extraction des noms des ingrédients
Les noms des ingrédients sont stockés en tant qu'attributs `nom` :
```bash
xmllint --xpath "//ingredient/@nom" recettes2.xml
```

##### 3. Extraction du titre de la deuxième recette
```bash
xmllint --xpath "//recette[2]/titre" recettes2.xml
```

##### 4. Extraction de la dernière étape de chaque recette
```bash
xmllint --xpath "//texte/etape[last()]" recettes2.xml
```

##### 5. Comptage du nombre total de recettes
```bash
xmllint --xpath "count(//recette)" recettes2.xml
```

##### 6. Sélection des recettes avec strictement moins de 7 ingrédients
On filtre les recettes ayant moins de 7 `ing-recette` :
```bash
xmllint --xpath "//recette[count(ingredients/ing-recette) < 7]" recettes2.xml
```

##### 7. Extraction des titres des recettes avec strictement moins de 7 ingrédients
```bash
xmllint --xpath "//recette[count(ingredients/ing-recette) < 7]/titre" recettes2.xml
```

##### 8. Extraction des recettes contenant de la farine
On vérifie que l'attribut `ingredient` est égal à "farine" :
```bash
xmllint --xpath "//recette[ingredients/ing-recette/@ingredient = 'farine']" recettes2.xml
```

##### 9. Extraction des recettes de la catégorie "entrée"
La catégorie est stockée sous forme d'IDREFS, donc on vérifie qu'elle contient "entree" :
```bash
xmllint --xpath "//recette[contains(@categ, 'entree')]" recettes2.xml
```

---
### Exercice 1.3 - iTunes

Analyse du fichier `iTunes-Music-Library.xml`

---

##### 1. Nombre de morceaux (tracks hors PlayLists) de la bibliothèque :
Cette requête compte tous les éléments `dict` qui ont une clé avec la valeur `Track ID`, ce qui indique une piste individuelle :

```bash
xmllint --xpath "count(//dict[key='Track ID'])" iTunes-Music-Library.xml
```

##### 2. Tous les noms d’albums :
Cette requête recherche les éléments `string` qui suivent immédiatement une clé avec la valeur `Album` :

```bash
xmllint --xpath "//dict[key='Album']/string[preceding-sibling::key[1]='Album']" iTunes-Music-Library.xml
```

##### 3. Tous les genres de musique (Jazz, Rock, etc.) :
Pour extraire les genres musicaux, on effectue la même requête avec la valeur `Genre` :

```bash
xmllint --xpath "//dict[key='Genre']/string[preceding-sibling::key[1]='Genre']" iTunes-Music-Library.xml
```

##### 4. Nombre de morceaux de Jazz :
Cette requête compte les éléments `dict` qui contiennent un genre `Jazz` :

```bash
xmllint --xpath "count(//dict[key='Genre' and string[preceding-sibling::key[1]='Genre']='Jazz'])" iTunes-Music-Library.xml
```

##### 5. Tous les genres de musique, en éliminant les doublons :
Pour éliminer les doublons dans la requête, on utilise `distinct-values` sur la liste des genres :

```bash
xmllint --xpath "//dict[key='Genre']/string[preceding-sibling::key[1]='Genre'][not(. = preceding::dict[key='Genre']/string[preceding-sibling::key[1]='Genre'])]" iTunes-Music-Library.xml
```

##### 6. Titres (`Name`) des morceaux qui ont été écoutés au moins une fois :
Cette requête recherche les morceaux dont le `Play Count` est supérieur à 0 :

```bash
xmllint --xpath "//dict[key='Play Count' and integer[preceding-sibling::key[1]='Play Count'] > 0]/string[preceding-sibling::key[1]='Name']" iTunes-Music-Library.xml
```

##### 7. Titres des morceaux qui n’ont jamais été écoutés :
Pour trouver les morceaux qui n’ont jamais été joués, on utilise `not` sur la clé `Play Count` :

```bash
xmllint --xpath "//dict[not(key='Play Count')]/string[preceding-sibling::key[1]='Name']" iTunes-Music-Library.xml
```

##### 8. Titre(s) du (ou des) morceaux les plus anciens (basé sur le champ `Year`) :
On recherche tous les éléments `dict` qui contiennent une clé `Year`, puis on récupère le titre du morceau le plus ancien.
- `../integer[preceding-sibling::key[1]='Year']` récupère l'année du morceau actuel.
- `//dict[key='Year']/integer[preceding-sibling::key[1]='Year']` récupère toutes les années présentes dans la bibliothèque.
- La condition `not(... > ...)` permet de s'assurer qu'il n'existe aucune année plus ancienne que celle actuelle.

```bash
xmllint --xpath "//dict[key='Year']/string[preceding-sibling::key[1]='Name']
[not(../integer[preceding-sibling::key[1]='Year'] >
//dict[key='Year']/integer[preceding-sibling::key[1]='Year'])]" iTunes-Music-Library.xml
```

Exemple de résultat :

```
<string>Annie Laurie</string>
<string>Midnight Special</string>
<string>Lowe Groovin'</string>
<string>The Applejack</string>
```


---

### Exercice 2 - SQL

---

### **Interroger un graphe avec SQLite**

Dans cet exercice, nous avons utilisé **SQLite** pour analyser un graphe de relations "follower/followed" issu de Twitter.

### **1. Création de la base de données et de la table**
Nous avons d'abord ouvert SQLite et créé une base de données **social_network.db** :

```bash
sqlite3 social_network.db
```

