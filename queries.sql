-- Voir le fichier Rapport_tests.md pour l'explication

-- 1) Afficher la liste des noms des focaccias par ordre alphabétique croissant,
SELECT nom
FROM focaccia
ORDER BY nom ASC;

-- 2) Afficher le nombre total d'ingrédients,
SELECT COUNT(id_ingredient) AS nbr_ingredients
FROM ingredient;

--3) Afficher le prix moyen des focaccias,
SELECT AVG(prix) AS prix_moy_focaccias
FROM focaccia;

--4) Afficher la liste des boissons avec leur marque, triée par nom de boisson,
SELECT boisson.nom, marque.nom 
FROM boisson
INNER JOIN marque
    ON boisson.id_marque = marque.id_marque
    ORDER BY boisson.nom ASC;

-- 5) Afficher la liste des ingrédients pour une Raclaccia,
SELECT nom
FROM ingredient
INNER JOIN comprend
    ON comprend.id_ingredient = ingredient.id_ingredient
WHERE id_focaccia = (
    SELECT id_focaccia
    FROM focaccia
    WHERE nom = 'Raclaccia'
);

-- 6) Afficher le nom et le nombre d'ingrédients pour chaque foccacia,
SELECT 
    focaccia.nom AS focaccia,
    COUNT(comprend.id_ingredient) AS nbr_ingredients,
    GROUP_CONCAT(ingredient.nom SEPARATOR '\n') AS ingredients
FROM focaccia
INNER JOIN comprend
    ON focaccia.id_focaccia = comprend.id_focaccia
INNER JOIN ingredient
    ON comprend.id_ingredient = ingredient.id_ingredient
GROUP BY focaccia.id_focaccia, focaccia.nom;

-- 7) Afficher le nom de la focaccia qui a le plus d'ingrédients,
SELECT 
    focaccia.nom,
    COUNT(comprend.id_ingredient) AS nbr_ingredients
FROM focaccia
INNER JOIN comprend
    ON focaccia.id_focaccia = comprend.id_focaccia
GROUP BY focaccia.id_focaccia, focaccia.nom
ORDER BY nbr_ingredients DESC
LIMIT 1;

-- 8) Afficher la liste des focaccia qui contiennent de l'ail,
SELECT focaccia.nom
FROM focaccia
INNER JOIN comprend
	ON focaccia.id_focaccia = comprend.id_focaccia
INNER JOIN ingredient
	ON comprend.id_ingredient = ingredient.id_ingredient
WHERE ingredient.nom LIKE 'Ail';

-- 9) Afficher la liste des ingrédients inutilisés,
SELECT ingredient.nom
FROM ingredient
LEFT JOIN comprend
    ON ingredient.id_ingredient = comprend.id_ingredient
WHERE comprend.id_ingredient IS NULL;

-- 10) Afficher la liste des focaccia qui n'ont pas de champignons.
SELECT nom
FROM focaccia
WHERE id_focaccia NOT IN (
    SELECT focaccia.id_focaccia
    FROM focaccia
    INNER JOIN comprend
        ON focaccia.id_focaccia = comprend.id_focaccia
    INNER JOIN ingredient
        ON ingredient.id_ingredient = comprend.id_ingredient
    WHERE ingredient.nom = 'champignon'
);