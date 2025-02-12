# Interroger des Bases de Données Non-Relationnelles

Ce répertoire contient les fichiers et solutions pour le TD de Schémas pour XML. Ci-dessous, les exercices et la validation des fichiers XML et DTD sont détaillés.

**Fait par : CHICA Miller et TORRES Jonathan**


## Structure du répertoire

- **Exercice 1** : `abc.xml`

## Exercices

### Exercice 1 : Premiers pas

#### 1. //e/preceding::text()
Se usa `//e` para ir al nodo de `e` dentro del archivo, despues por medio del `preceding` se busca todos los valores anteriores dentro del nodo de `c` y el nodo `b`, encontrando el texto `bli`, de esta manera si hay texto antes de dicho nodo, sera mostrado.

El comando usado es el siguiente :

```bash
xmllint --xpath "//e/preceding::text()" abc.xml
```

El resultado es `bli`.

#### 2. count(//c|//b/node())
Esta consulta cuenta todos los elementos de `c` y los nodos hijos de `b` donde se incluyen los elementos y textos, por lo cual si ya fue contado el nodo `c`, ya no sera contado dentro de los hijos de `b`.

El comando usado es el siguiente :

```bash
xmllint --xpath "/count(//c|//b/node())" abc.xml
```

EL resultado es `4`.

#### 3. La somme de tous les attributs.

```bash
xmllint --xpath "sum(//@*)" abc.xml
```

#### 4. Le contenu textuel du document, où chaque ’b’ est remplacé par un ’c’
Por medio del comando string es posible leer la concantenacion de los strings The string value of an element or document node is the concatenation of
the character data in all text nodes below.

```bash
xmllint --xpath "translate(string(/),'b','c')" abc.xml
```

#### 5. Le nom du fils du dernier ´elément ’c’ dans l’arbre.

```bash
xmllint --xpath "name(//c[position()=last()]/*)" abc.xml
```

```bash
xmllint --xpath "name(//c[last()]/*)" abc.xml
```
#### 6. 
Con el archivo editado se realizan los comandos de cada punto y se obtienen estas respuestas:
##### 1. //e/preceding::text()

---
