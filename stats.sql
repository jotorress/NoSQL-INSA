-- Création de la table pour stocker les relations friend/follower
CREATE TABLE IF NOT EXISTS followers (
    user_id INTEGER,
    follower_id INTEGER
);

-- Importation des données depuis le fichier CSV (doit être décompressé)
.mode csv
.separator " "
.import social_network.edgelist followers

-- Création d'une vue pour calculer le nombre de followers par utilisateur
CREATE VIEW followers_count AS
SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id;

-- Compter le nombre total de relations friend/follower
SELECT 'nb total de relations friend/follower :', COUNT(*) FROM followers;

-- Compter le nombre d'utilisateurs ayant au moins un follower
SELECT 'nb utilisateurs qui ont au moins un follower :', COUNT(*) FROM followers_count WHERE follower_count > 0;

-- Compter le nombre d'utilisateurs qui suivent au moins quelqu'un
SELECT 'nb utilisateurs qui suivent au moins qqn :', COUNT(DISTINCT follower_id) FROM followers;

-- Trouver un utilisateur avec le nombre maximal de followers
SELECT 'nb max de followers par utilisateur :', MAX(follower_count) FROM followers_count;

-- Trouver un exemple d'utilisateur avec le nombre maximal de followers
SELECT 'exemple dutilisateur avec nb max de followers :', user_id FROM followers_count WHERE follower_count = (SELECT MAX(follower_count) FROM followers_count);

-- Trouver un utilisateur avec le nombre minimal de followers
SELECT 'nb min de followers par utilisateur :', MIN(follower_count) FROM followers_count;

-- Trouver un exemple d'utilisateur avec le nombre minimal de followers
SELECT 'exemple dutilisateur avec min de followers :', user_id FROM followers_count WHERE follower_count = (SELECT MIN(follower_count) FROM followers_count);
