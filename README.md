# Interroger des Bases de Données Non-Relationnelles

Ce répertoire contient les fichiers et solutions pour le TD des Bases de Données Non-Relationnelles.

**Fait par : CHICA Miller et TORRES Jonathan**


## Structure du répertoire

- **Exercice 1** : `abc.xml`

## Exercices

### Exercice 1.1 : Premiers pas

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
El resultado es `10`.

#### 4. Le contenu textuel du document, où chaque ’b’ est remplacé par un ’c’.
Por medio del comando string es posible leer la concantenacion de los strings The string value of an element or document node is the concatenation of
the character data in all text nodes below.

```bash
xmllint --xpath "translate(string(/),'b','c')" abc.xml
```
El resultado es `cliclacou`.

#### 5. Le nom du fils du dernier ´elément ’c’ dans l’arbre.

```bash
xmllint --xpath "name(//c[position()=last()]/*)" abc.xml
```

```bash
xmllint --xpath "name(//c[last()]/*)" abc.xml
```
El resultado es `e`.

#### 6. 

##### 1. //e/preceding::text()
XPath toma los espacios y saltos de lineas como nodos de texto vacios, por lo cual el resultado es el mismo pero con espacios entre el texto presentado:

  bli
  
##### 2. count(//c|//b/node())
El resultado es `8`, esto sucede por los espacios que existen dentro de la identacion siendo `textos vacios`, lo cual se puede denotar por medio del comando

```bash
xmllint --shell abc.xml 
/ > xpath //c|//b/node()
```

Donde el resultado es correspondiente a:
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
##### 3. La somme de tous les attributs.
El resultado sigue siendo `10` ya que se asume que los elementos vacios no estan siendo sumados dentro del comando, solamente los atributos.

##### 4. Le contenu textuel du document, où chaque ’b’ est remplacé par un ’c’.
EL resultado es el esperado, solamente se imprimen los espacios por la identacion realizada, explicada en el primer punto.
```bash





cli


cla


cou


```

##### 5. Le nom du fils du dernier ´elément ’c’ dans l’arbre.
El resultado sigue siendo `e` porque estamos buscando un valor en especifico que en este caso es un name, por lo cual la identacion o espacios vacios no afectan el comando.

---


### Exercice 1.2 Recettes


