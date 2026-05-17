-- Utiliser la BDD si le serveur a été éteint auparavant avec le script: USE tifosi;

-- =================================
-- Alimentation des tables principales
-- =================================

-- Alimentation de la table marque

INSERT INTO marque (nom)
VALUES
('Coca-Cola'),
('Cristalline'),
('Monster'),
('Pepsico');

-- Alimentation de la table focaccia

INSERT INTO focaccia (nom, prix)
VALUES
('Mozaccia',9.80),
('Gorgonzollaccia',10.80),
('Raclaccia',8.90),
('Emmentalaccia',9.80),
('Tradizione',8.90),
('Hawaienne',11.20),
('Américaine',10.80),
('Paysanne',12.80);

-- Alimentation de la table ingredient en important les données du fichier .csv
/*
Tentative d’import via LOAD DATA LOCAL INFILE,
mais fonctionnalité désactivée sur le serveur MySQL.
Les données ont donc été insérées manuellement.

Exemple script pour ingredient:

LOAD DATA LOCAL INFILE 'tables_xlsx_csv/ingredient.csv'
INTO TABLE ingredient
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
*/

-- Alimentation de la table ingredient

INSERT INTO ingredient (nom)
VALUES
('Ail'),
('Ananas'),
('Artichaut'),
('Bacon'),
('Base Tomate'),
('Base crème'),
('Champignon'),
('Chevre'),
('Cresson'),
('Emmental'),
('Gorgonzola'),
('Jambon cuit'),
('Jambon fumé'),
('Oeuf'),
('Oignon'),
('Olive noire'),
('Olive verte'),
('Parmesan'),
('Piment'),
('Poivre'),
('Pomme de terre'),
('Raclette'),
('Salami'),
('Tomate cerise'),
('Mozarella');

-- Alimentation de la table boisson 

INSERT INTO boisson (id_boisson, id_marque, nom)
VALUES
(1,1,'Coca-cola zéro'),
(2,1,'Coca-cola original'),
(3,1,'Fanta citron'),
(4,1,'Fanta orange'),
(5,1,'Capri-sun'),
(6,4,'Pepsi'),
(7,4,'Pepsi Max Zéro'),
(8,4,'Lipton zéro citron'),
(9,4,'Lipton Peach'),
(10,3,'Monster energy ultra gold'),
(11,3,'Monster energy ultra blue'),
(12,2,'Eau de source ');

-- =================================
-- Alimentation des tables associees (relation)
-- =================================

--Alimentation de la table Relation Comprend
/*
Le fichier focaccia.xlsx contenant les recettes sous forme textuelle,
un fichier intermédiaire focaccia_ingredient a été créé afin de faciliter
l’alimentation de la table relationnelle comprend.
*/

INSERT INTO comprend (id_ingredient, id_focaccia, quantite)
VALUES
-- Mozaccia
(1,1,2),
(3,1,20),
(5,1,200),
(7,1,40),
(9,1,20),
(13,1,80),
(16,1,20),
(18,1,50),
(20,1,1),
(25,1,50),
-- Gorgonzollaccia
(1,2,2),
(5,2,200),
(7,2,40),
(9,2,20),
(11,2,50),
(16,2,20),
(18,2,50),
(20,2,1),
-- Raclaccia
(1,3,2),
(5,3,200),
(7,3,40),
(9,3,20),
(18,3,50),
(20,3,1),
(22,3,50),
-- Emmentalaccia
(5,4,200),
(7,4,40),
(9,4,20),
(15,4,20),
(18,4,50),
(20,4,1),
(25,4,50),
-- Tradizione
(5,5,200),
(7,5,80),
(9,5,20),
(12,5,80),
(16,5,10),
(17,5,10),
(21,5,50),
(20,5,1),
(25,5,50),
-- Hawaienne
(2,6,40),
(4,6,80),
(5,6,200),
(9,6,20),
(16,6,20),
(18,6,50),
(19,6,2),
(20,6,1),
(25,6,50),
-- Americaine
(4,7,80),
(5,7,200),
(9,7,20),
(16,7,20),
(18,7,50),
(20,7,1),
(21,7,40),
(25,7,50),
-- Paysanne
(1,8,2),
(3,8,20),
(6,8,200),
(7,8,40),
(8,8,50),
(9,8,20),
(13,8,80),
(14,8,50),
(16,8,20),
(18,8,50),
(20,8,1),
(21,8,80);