-- Création de la table pour stocker les relations de followers
CREATE TABLE followers (
    user_id INTEGER,
    follower_id INTEGER
);

-- Changer le séparateur pour l'importation
.separator " "

-- Importer les données depuis le fichier CSV
.import social_network.edgelist followers

-- Nombre total de relations (tuples dans la table)
SELECT 'nb total de relations friend/follower :', COUNT(*) FROM followers;

-- Nombre d'utilisateurs ayant au moins un follower
SELECT 'nb utilisateurs qui ont au moins un follower :', COUNT(DISTINCT user_id) FROM followers;

-- Nombre d'utilisateurs qui suivent au moins une personne
SELECT 'nb utilisateurs qui suivent au moins qqn :', COUNT(DISTINCT follower_id) FROM followers;

-- Utilisateur ayant le plus grand nombre de followers
SELECT 'nb max de followers par utilisateur :', MAX(follower_count) FROM (
    SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id
);
SELECT 'exemple d'utilisateur avec nb max de followers :', user_id 
FROM (SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id ORDER BY follower_count DESC LIMIT 1);

-- Utilisateur ayant le plus petit nombre de followers
SELECT 'nb min de followers par utilisateur :', MIN(follower_count) FROM (
    SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id
);
SELECT 'exemple d'utilisateur avec min de followers :', user_id 
FROM (SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id ORDER BY follower_count ASC LIMIT 1);
