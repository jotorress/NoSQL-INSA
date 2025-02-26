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

#### **1. Création de la base de données et de la table**
Nous avons d'abord ouvert SQLite et créé une base de données **social_network.db** :

```bash
sqlite3 social_network.db
```

Ensuite, nous avons défini la structure de la table followers :

```
CREATE TABLE followers (
    user_id INTEGER,
    follower_id INTEGER
);
```
#### **2. Importation des données**

Le fichier higgs-social_network.edgelist contient la liste des relations sous forme de paires (follower_id, user_id).
Nous avons importé ces données dans SQLite en utilisant l'espace " " comme séparateur :

```
.separator " "
.import higgs-social_network.edgelist followers
```

#### **3. Exécution des requêtes SQL**

Enfin, nous avons exécuté le script stats.sql contenant les requêtes demandées :


```
sqlite3 social_network.db < stats.sql
```

Ce script génère les statistiques suivantes :

- **Nombre total de relations** (liens follower/followed) : `14 855 842`
- **Nombre d’utilisateurs ayant au moins un follower** : `456 626`
- **Nombre d’utilisateurs qui suivent au moins une personne** : `370 341`
- **Utilisateur ayant le plus de followers** : `1 259`
  - **Exemple d’utilisateur avec ce nombre de followers** : `13 115`
- **Utilisateur ayant le moins de followers** : `1`
  - **Exemple d’utilisateur avec ce nombre de followers** : `17`

Les résultats sont affichés directement dans le terminal.

#### **4. Exportation des résultats**

Si nécessaire, les résultats peuvent être enregistrés dans un fichier texte :

```
sqlite3 social_network.db < stats.sql > resultats.txt

```


---

### **3.1 Joueurs de foot**

---

### **0. Testez la requête `foot.sparql` et expliquez son résultat**  

La requête SPARQL contenue dans le fichier `foot.sparql` est exécutée en utilisant la commande suivante :  

```bash
sparql --data foot.ttl --query foot.sparql
```

##### **Explication de la requête**  
La requête extrait des informations sur le joueur **Antoine Griezmann** à partir du fichier RDF `foot.ttl`. Plus précisément, elle sélectionne les variables suivantes :  
- `?euro` : L’année du championnat d’Europe auquel il a participé.  
- `?numero` : Le numéro associé au joueur (probablement son numéro de maillot).  
- `?matches` : Le nombre de matchs joués lors de cette édition du tournoi.  
- `?goals` : Le nombre de buts marqués lors de ce championnat.  

La requête utilise des clauses `OPTIONAL` pour inclure les valeurs de `?matches` et `?goals`, ce qui permet à ces champs d’être vides si aucune donnée n’est disponible.  

##### **Résultat obtenu**  
Le résultat de la requête est le suivant :  

```
-----------------------------------
| euro | numero | matches | goals |
===================================
| 2016 | 7      | 7       | 6     |
| 2020 | 7      | 4       | 1     |
| 2024 | 7      | 6       |       |
-----------------------------------
```

##### **Interprétation du résultat**  
- **Euro 2016** :  
  - **Numéro** : 7 (probablement son numéro de maillot).  
  - **Matchs joués** : 7.  
  - **Buts marqués** : 6.  

- **Euro 2020** :  
  - **Numéro** : 7.  
  - **Matchs joués** : 4.  
  - **Buts marqués** : 1.  

- **Euro 2024** :  
  - **Numéro** : 7.  
  - **Matchs joués** : 6.  
  - **Buts marqués** : Champ vide (aucune donnée disponible, peut-être parce que le championnat n’est pas encore terminé ou que les buts n’ont pas été enregistrés).  

#### **1. Les joueurs et le nombre d’euros auxquels ils ont participé (en ordre décroissant).**

```
PREFIX : <https://www.example.org/foot#>

SELECT (?name AS ?player) (COUNT(DISTINCT ?euro) AS ?count_euros)
WHERE
{
  ?id_participation :player ?id_player; :euro ?euro.
  ?id_player :name ?name.
}
GROUP BY ?name
ORDER BY DESC(?count_euros)

```

Pour exécuter cette requête SPARQL dans la terminal avec Apache Jena, utilisez la commande suivante:
```bash
sparql --data foot.ttl --query f1.sparql
```

#### **2. Les joueurs et le nombre de matches qu’ils ont jou´e s’ils en ont jou´e au moins 1 (en ordre d´ecroissant)**
```
PREFIX : <https://www.example.org/foot#>

SELECT (?name AS ?player) (SUM(?matches) AS ?total_matches)
WHERE {
  ?id_participation :player ?id_player; :matches ?matches.
  ?id_player :name ?name.
}
GROUP BY ?name
HAVING (?total_matches >= 1)
ORDER BY DESC(?total_matches)

```
Pour exécuter cette requête SPARQL dans la terminal avec Apache Jena, utilisez la commande suivante:
```bash
sparql --data foot.ttl --query f2.sparql
```

#### **3. Les joueurs et le nombre de buts qu’ils ont marqué s’ils en ont marqué au moins 1 (en ordre décroissant), ainsi que le nombre de matches joués.**

```sparql
PREFIX : <https://www.example.org/foot#>

SELECT (?name AS ?player) (SUM(COALESCE(?goals,0)) AS ?total_goals) (SUM(COALESCE(?matches,0)) AS ?total_matches)
WHERE {
  ?id_participation :player ?id_player.
  ?id_player :name ?name.
  OPTIONAL{?id_participation :goals ?goals. } 
  OPTIONAL{?id_participation :matches ?matches. }             

}
GROUP BY ?name
HAVING (?total_goals > 0)
ORDER BY DESC(?total_goals) DESC(?total_matches)
```

---

Pour exécuter cette requête SPARQL dans la terminal avec Apache Jena, utilisez la commande suivante:
```bash
sparql --data foot.ttl --query f3.sparql
```

#### **4. Les joueurs qui ont marqué dans deux euros différents.**

```sparql
PREFIX : <https://www.example.org/foot#>

SELECT DISTINCT ?player ?euro1 ?goals1 ?euro2 ?goals2
WHERE {
  ?id_participation1 :player ?id_player; :euro ?euro1; :goals ?goals1.
  ?id_participation2 :player ?id_player; :euro ?euro2; :goals ?goals2.
  FILTER (?euro1 < ?euro2)
  ?id_player :name ?player.
}
ORDER BY ?euro1 DESC(?player)
```

---

Pour exécuter cette requête SPARQL dans la terminal avec Apache Jena, utilisez la commande suivante:
```bash
sparql --data foot.ttl --query f4.sparql
```

#### **5. Le rapport complet de tous les euros, les joueurs participants avec leurs nombre de matches et de buts.**

```sparql
PREFIX : <https://www.example.org/foot#>

SELECT ?euro ?n ?name ?matches ?goals
WHERE {
  ?id_participation :player ?id_player; :euro ?euro; :n ?n.
  OPTIONAL { ?id_participation :matches ?matches. }
  OPTIONAL { ?id_participation :goals ?goals. }
  ?id_player :name ?name.
}

ORDER BY DESC(?euro) ASC(?n)
```

---
Pour exécuter cette requête SPARQL dans la terminal avec Apache Jena, utilisez la commande suivante:
```bash
sparql --data foot.ttl --query f5.sparql
```

---

### **3.2 Joueurs de foot**

---

#### **0. Testez la requête dept.sparql et expliquez son résultat..**

##### Analyse de la requête SPARQL et des résultats

La requête SPARQL a pour objectif de compter le nombre de relations de voisinage (`:aVoisin`) entre les régions françaises dans une base de données RDF.

##### Requête SPARQL
```sparql
PREFIX : <https://www.example.org/departements#>
SELECT COUNT(*) WHERE
{
  ?x1 :aVoisin ?x2.
}
```

##### Résultat
```
------
| .1 |
======
| 23 |
------
```

##### Explication
- La requête compte toutes les relations de voisinage (`:aVoisin`) dans la base de données.
- Le résultat **23** indique qu'il y a 23 paires de régions qui sont voisines.

##### Interprétation
- Les régions françaises sont fortement interconnectées.
- Ce résultat est utile pour des analyses géographiques ou des études de connectivité régionale.


#### **1. Sélectionnez les régions (en ordre alphabétique) avec le chef-lieu, ainsi que pour chaque département de la région : le numéro, le nom et la préfecture.**

**Requête SPARQL :**
```sparql
PREFIX : <https://www.example.org/departements#>

SELECT ?x1 ?x2 ?x3 ?x4 ?x5 ?x6
WHERE {
  ?region :nom ?x1;
          :chefLieu ?x2;
          :contientDept ?x3.

  ?x3 :nom ?x4;
      :préfecture ?x5.
}
ORDER BY ?x1 ?x3
```

---

#### **2. Sélectionnez les numéros de département (en ordre croissant), avec le nom de département, la préfecture et la région.**

**Requête SPARQL :**
```sparql
PREFIX : <https://www.example.org/departements#>

SELECT ?x4 ?x5 ?x6 ?x2
WHERE {
  ?region :nom ?x2;
          :contientDept ?x4.
  
  ?x4 :nom ?x5;
           :préfecture ?x6.
}
ORDER BY ?x4

```

#### **3. Construisez la clôture symétrique de la relation `aVoisin`.**

**Requête SPARQL :**
```sparql
PREFIX : <https://www.example.org/departements#>

CONSTRUCT {
  ?region1 :aVoisinSym ?region2.
  ?region2 :aVoisinSym ?region1.
}
WHERE {
  ?region1 :aVoisin ?region2.
}

```

#### **4. Construisez la clôture transitive de la clôture symétrique de la relation `aVoisin`.**

**Requête SPARQL :**
```sparql
PREFIX : <https://www.example.org/departements#>

CONSTRUCT {
  ?x :aVoisin ?y .
}
WHERE {
  ?x ( :aVoisin | ^:aVoisin)+ ?y.
}

```


#### **5. Parmi les différents cas d’utilisation que vous venez de manipuler, lequel semble plus adéquat pour utiliser des bases de données orientées graphes et pourquoi ?**

**Réponse :**
Le cas d'utilisation le plus adapté pour une base de données orientée graphe est la **clôture transitive** (point 4). Les bases de données orientées graphes sont conçues pour gérer des relations complexes et des requêtes récursives, comme celles nécessaires pour calculer la clôture transitive.

#### **6. Pour quel cas d’utilisation vous privilégieriez plutôt les données relationnelles et pourquoi ?**

**Réponse :**
Les données relationnelles sont plus adaptées pour les **requêtes simples** comme la sélection des régions et départements (points 1 et 2). Ces requêtes ne nécessitent pas de relations complexes ou récursives, ce qui correspond bien au modèle relationnel.


---

