
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