
-- =================================
-- ADMIN (setup base + user)
-- =================================

DROP DATABASE IF EXISTS tifosi;

-- Création de la BDD tifosi
CREATE DATABASE tifosi
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Création de l'utilisateur de tifosi
CREATE USER 'tifosi'@'localhost'
-- Remplacer le mot de passe avant exécution
IDENTIFIED BY 'toChangeByRealPassword';

-- Droits sur la BDD
GRANT ALL PRIVILEGES
ON tifosi.*
TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- =================================
-- SCHEMA (tables)
-- =================================

-- Utiliser la BDD
USE tifosi;

-- tables principales

-- Ingrédient
CREATE TABLE IF NOT EXISTS ingredient (
    id_ingredient INTEGER PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL
);

-- Focaccia
CREATE TABLE IF NOT EXISTS focaccia (
    id_focaccia INTEGER PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(5, 2)
);

-- Menu
CREATE TABLE IF NOT EXISTS menu (
    id_menu INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_focaccia INTEGER,
    FOREIGN KEY (id_focaccia)
        REFERENCES focaccia(id_focaccia),
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(5, 2)
);

-- Client
CREATE TABLE IF NOT EXISTS client (
    id_client INTEGER PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    code_postal INTEGER
);

-- Marque
CREATE TABLE IF NOT EXISTS marque (
    id_marque INTEGER PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL
);

-- Boisson
CREATE TABLE IF NOT EXISTS boisson (
    id_boisson INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_marque INTEGER,
    FOREIGN KEY (id_marque)
        REFERENCES marque(id_marque),
    nom VARCHAR(50) NOT NULL
);

-- tables associatives

-- Relation Comprend
CREATE TABLE IF NOT EXISTS comprend (
    id_ingredient INTEGER,
    id_focaccia INTEGER,
    quantite INTEGER NOT NULL,

    PRIMARY KEY (id_ingredient, id_focaccia),

    FOREIGN KEY (id_ingredient)
        REFERENCES ingredient(id_ingredient),

    FOREIGN KEY (id_focaccia)
        REFERENCES focaccia(id_focaccia)
);

-- Relation Achete
CREATE TABLE IF NOT EXISTS achete (
    id_client INTEGER,
    id_menu INTEGER,
    date_achat DATE NOT NULL,

    PRIMARY KEY (id_client, id_menu),

    FOREIGN KEY (id_client)
        REFERENCES client(id_client),

    FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu)
);

-- Relation Contient
CREATE TABLE IF NOT EXISTS contient (
    id_menu INTEGER,
    id_boisson INTEGER,

    PRIMARY KEY (id_menu, id_boisson),

    FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu),

    FOREIGN KEY (id_boisson)
        REFERENCES boisson(id_boisson)
);