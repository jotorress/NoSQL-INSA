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
SELECT 'nb utilisateurs qui ont au moins un follower :', COUNT(*) FROM followers_count;

-- Compter le nombre d'utilisateurs qui suivent au moins quelqu'un
SELECT 'nb utilisateurs qui suivent au moins qqn :', COUNT(DISTINCT follower_id) FROM followers;

-- Trouver un utilisateur avec le nombre maximal de followers
WITH max_followers AS (
    SELECT user_id, follower_count FROM followers_count ORDER BY follower_count DESC LIMIT 1
)
SELECT 'nb max de followers par utilisateur :', follower_count FROM max_followers;

SELECT 'exemple dutilisateur avec nb max de followers :', user_id FROM max_followers;

-- Trouver un utilisateur avec le nombre minimal de followers
WITH min_followers AS (
    SELECT user_id, follower_count FROM followers_count ORDER BY follower_count ASC LIMIT 1
)
SELECT 'nb min de followers par utilisateur :', follower_count FROM min_followers;

SELECT 'exemple dutilisateur avec min de followers :', user_id FROM min_followers;
