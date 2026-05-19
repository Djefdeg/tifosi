
## Test 1 — Tri des focaccias
------------------------------
### But
Vérifier l’ordre alphabétique.

### Code SQL
SELECT nom 
FROM focaccia 
ORDER BY nom ASC;

### Résultat attendu
Liste triée A → Z

### Résultat obtenu
Américaine
Emmentalaccia
Gorgonzollaccia
Hawaienne
Mozaccia
Paysanne
Raclaccia
Tradizione

### Commentaire
Conforme

## Test 2 — Nombre total d'ingredients
------------------------------
### But
Calculer le nombre total d'ingredient de la table ingredient.

### Code SQL
SELECT COUNT(id_ingredient) AS nbr_ingredients
FROM ingredient;

### Résultat attendu
25

### Résultat obtenu
25

### Commentaire
Conforme

## Test 3 — Prix moyen des focaccias
------------------------------
### But
Calculer le prix moyen des focaccias.

### Code SQL
SELECT AVG(prix) AS prix_moy_focaccias
FROM focaccia;

### Résultat attendu
10.375

### Résultat obtenu
10.375

### Commentaire
Conforme

## Test 4 — Liste triées des boissons avec leurs marques
------------------------------
### But
Afficher la liste triées des boissons avec leurs marques

### Code SQL
SELECT boisson.nom, marque.nom 
FROM boisson
INNER JOIN marque
    ON boisson.id_marque = marque.id_marque
    ORDER BY boisson.nom ASC;

### Résultat attendu
Capri-sun                   Coca-Cola
Coca-cola original          Coca-Cola
Coca-cola zéro              Coca-Cola
Eau de source               Cristalline
Fanta citron                Coca-Cola
Fanta orange                Coca-Cola
Lipton Peach                Pepsico
Lipton zéro citron          Pepsico
Monster energy ultra blue   Monster
Monster energy ultra gold   Monster
Pepsi                       Pepsico
Pepsi Max Zéro              Pepsico

### Résultat obtenu
Capri-sun                   Coca-Cola
Coca-cola original          Coca-Cola
Coca-cola zéro              Coca-Cola
Eau de source               Cristalline
Fanta citron                Coca-Cola
Fanta orange                Coca-Cola
Lipton Peach                Pepsico
Lipton zéro citron          Pepsico
Monster energy ultra blue   Monster
Monster energy ultra gold   Monster
Pepsi                       Pepsico
Pepsi Max Zéro              Pepsico

### Commentaire
Conforme

## Test 5 — Afficher la liste des ingrédients pour une Raclaccia,
------------------------------
### But
Liste des ingrédients pour une Raclaccia,

### Code SQL
SELECT nom
FROM ingredient
INNER JOIN comprend
    ON comprend.id_ingredient = ingredient.id_ingredient
WHERE id_focaccia = (
    SELECT id_focaccia
    FROM focaccia
    WHERE nom = 'Raclaccia'
);

### Résultat attendu
Ail
Base Tomate
Champignon
Cresson
Parmesan
Poivre
Raclette

### Résultat obtenu
Ail
Base Tomate
Champignon
Cresson
Parmesan
Poivre
Raclette

### Commentaire
Conforme

## Test 6 — Afficher le nom et le nombre d'ingrédients pour chaque foccacia,
------------------------------
### But
Noms et nombres d'ingredients pour chaque focaccia

### Code SQL
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

### Résultat attendu
focaccia 	nbr_ingredients 	ingredients 	
Mozaccia.         10 	           Ail
                                 Artichaut
                                 Base Tomate
                                 Champignon
                                 Cresson
                                 Jambon fumé
                                 Olive noire
                                 Parmesan
                                 Poivre
                                 Mozarella
Gorgonzollaccia.   8 	         Ail
                                 Base Tomate
                                 Champignon
                                 Cresson
                                 Gorgonzola
                                 Olive noire
                                 Parmesan
                                 Poivre
Ainsi de suite pour toutes les focaccia

### Résultat obtenu
focaccia 	nbr_ingredients 	ingredients 	
Mozaccia.         10 	           Ail
                                 Artichaut
                                 Base Tomate
                                 Champignon
                                 Cresson
                                 Jambon fumé
                                 Olive noire
                                 Parmesan
                                 Poivre
                                 Mozarella
Gorgonzollaccia.   8 	         Ail
                                 Base Tomate
                                 Champignon
                                 Cresson
                                 Gorgonzola
                                 Olive noire
                                 Parmesan
                                 Poivre
Ainsi de suite pour toutes les focaccia

### Commentaire
Conforme (nb: il faut cocher texte complet dans options supplémentaires pour afficher tous les ingrédients)

## Test 7 — Afficher le nom de la focaccia qui a le plus d'ingrédients,
------------------------------
### But
Nom de la focaccia qui a le plus d'ingrédients,

### Code SQL
SELECT 
    focaccia.nom,
    COUNT(comprend.id_ingredient) AS nbr_ingredients
FROM focaccia
INNER JOIN comprend
    ON focaccia.id_focaccia = comprend.id_focaccia
GROUP BY focaccia.id_focaccia, focaccia.nom
ORDER BY nbr_ingredients DESC
LIMIT 1;

### Résultat attendu

nom 	nbr_ingredients 	
Paysanne      12

### Résultat obtenu
nom 	nbr_ingredients 	
Paysanne      12

### Commentaire
Conforme 
Si on veut afficher le nom sans le nombre:
    On supprime COUNT(comprend.id_ingredient) AS nbr_ingredients dans SELECT
    On remplace nbr_ingredients par COUNT(comprend.id_ingredient) dans ORDER BY nbr_ingredients DESC

## Test 8 — Afficher la liste des focaccia qui contiennent de l'ail,
------------------------------
### But
Liste des focaccia qui contiennent de l'ail,

### Code SQL
SELECT focaccia.nom
FROM focaccia
INNER JOIN comprend
	ON focaccia.id_focaccia = comprend.id_focaccia
INNER JOIN ingredient
	ON comprend.id_ingredient = ingredient.id_ingredient
WHERE ingredient.nom LIKE 'Ail';

### Résultat attendu
Nom 	
Mozaccia
Gorgonzollaccia
Raclaccia
Paysanne

### Résultat obtenu
Nom 	
Mozaccia
Gorgonzollaccia
Raclaccia
Paysanne

### Commentaire
Conforme 

## Test 9 — Afficher la liste des ingrédients inutilisés,
------------------------------
### But
Liste des ingrédients non utilisés,

### Code SQL
SELECT ingredient.nom
FROM ingredient
LEFT JOIN comprend
    ON ingredient.id_ingredient = comprend.id_ingredient
WHERE comprend.id_ingredient IS NULL;

### Résultat attendu
 nom 	
Emmental
Salami
Tomate cerise

### Résultat obtenu
 nom 	
Emmental
Salami
Tomate cerise

### Commentaire
Conforme 

## Test 10 — Afficher la liste des focaccia qui n'ont pas de champignons.
------------------------------
### But
liste des focaccia qui n'ont pas de champignons.

### Code SQL
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

### Résultat attendu
 nom 	
Hawaienne
Américaine

### Résultat obtenu
 nom 	
Hawaienne
Américaine

### Commentaire
Conforme 