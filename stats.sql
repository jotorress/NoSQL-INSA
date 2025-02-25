-- Número total de relaciones (tuplas en la tabla)
SELECT 'nb total de relations friend/follower :', COUNT(*) FROM followers;

-- Número de usuarios que tienen al menos un follower
SELECT 'nb utilisateurs qui ont au moins un follower :', COUNT(DISTINCT user_id) FROM followers;

-- Número de usuarios que siguen al menos a una persona
SELECT 'nb utilisateurs qui suivent au moins qqn :', COUNT(DISTINCT follower_id) FROM followers;

-- Usuario con el mayor número de followers
SELECT 'nb max de followers per utilisateur :', MAX(follower_count) FROM (
    SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id
);
SELECT 'exemple utilisateur avec nb max de followers :', user_id 
FROM (SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id ORDER BY follower_count DESC LIMIT 1);

-- Usuario con el menor número de followers
SELECT 'nb min de followers per utilisateur :', MIN(follower_count) FROM (
    SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id
);
SELECT 'exemple utilisateur avec min de followers :', user_id 
FROM (SELECT user_id, COUNT(*) AS follower_count FROM followers GROUP BY user_id ORDER BY follower_count ASC LIMIT 1);

