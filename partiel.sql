-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mar 23 Février 2016 à 12:53
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `partiel`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Cat 1'),
(2, 'Cat 2');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `Categories_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Users_Categories1_idx` (`Categories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_Users_Categories1` FOREIGN KEY (`Categories_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-- -----------------------------------------------------
-- TRIGGER Création
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER UsersInsert AFTER INSERT INTO Users
FOR EACH ROW
BEGIN

INSERT INTO `users_audit` (`username`, `password`, `email`)
VALUES
(USER(), NEW.password, NEW.email);
END
//

-- -----------------------------------------------------
-- TRIGGER Modification
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER UsersUpdate AFTER UPDATE ON users
FOR EACH ROW
BEGIN

IF NEW.username IS NOT NULL THEN

IF EXISTS (SELECT 1 FROM users_audit WHERE username = NEW.username) THEN
UPDATE users_audit SET `username` = NEW.username, `password` = NEW.password, `email` = NEW.email WHERE username = OLD.username;
ELSE
INSERT INTO users_audit (`username`, `password`, `email`)
VALUES (NEW.username, NEW.password, NEW.email);
END IF;
END IF;
END
//

-- -----------------------------------------------------
-- TRIGGER Suppression
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER UsersDelete AFTER DELETE FROM Users
FOR EACH ROW
BEGIN

DELETE FROM `users_audit` (`username`, `password`, `email`)
VALUES
(USER(), NEW.password, NEW.email);
END
//