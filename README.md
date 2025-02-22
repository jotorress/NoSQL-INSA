# Interroger des Bases de Données Non-Relationnelles

Ce répertoire contient les fichiers et solutions pour le TD des Bases de Données Non-Relationnelles.

**Fait par : CHICA Miller et TORRES Jonathan**

## Structure du répertoire

- **Exercice 1.1** : `abc.xml`
- **Exercice 1.2** : `recettes1.xml`, `recettes1.dtd`, `recettes2.xml`, `recettes2.dtd`
- **Exercice 1.3** : `iTunes-Music-Library.xml`
 
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
Esta consulta cuenta todos los elementos dict que tienen una key con valor 'Track ID', lo que indica una pista individual :
```bash
xmllint --xpath "count(//dict[key='Track ID'])" iTunes-Music-Library.xml
```


##### 2. Tous les noms d’albums :
Esta consulta busca elementos string que siguen inmediatamente a una key con valor 'Album' :
```bash
xmllint --xpath "//dict[key='Album']/string[preceding-sibling::key[1]='Album']" iTunes-Music-Library.xml
```

##### 3. Tous les genres de musique (Jazz, Rock, etc.) :
Para el género de la musica se realiza la misma consulta con el valor 'Genre' :
```bash
xmllint --xpath "//dict[key='Album']/string[preceding-sibling::key[1]='Genre']" iTunes-Music-Library.xml
```

##### 4. Nombre de morceaux de Jazz :
```bash
xmllint --xpath "" iTunes-Music-Library.xml
```

##### 5. Tous les genres de musique, en éliminant les doublons :
```bash
xmllint --xpath "" iTunes-Music-Library.xml
```

##### 6. Titres (Name) des morceaux qui ont été écoutés au moins une fois :
```bash
xmllint --xpath "" iTunes-Music-Library.xml
```

##### 7. Titres des morceaux qui n’ont jamais été écoutés :
```bash
xmllint --xpath "" iTunes-Music-Library.xml
```

##### 8. Titre(s) du (ou des) morceaux les plus anciens (basé sur le champ Year) :
```bash
xmllint --xpath "" iTunes-Music-Library.xml
```

---

