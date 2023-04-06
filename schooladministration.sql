-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 06 avr. 2023 à 20:50
-- Version du serveur : 5.7.31
-- Version de PHP : 8.0.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `schooladministration`
--

-- --------------------------------------------------------

--
-- Structure de la table `classes`
--

DROP TABLE IF EXISTS `classes`;
CREATE TABLE IF NOT EXISTS `classes` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `classes`
--

INSERT INTO `classes` (`class_id`, `class_name`) VALUES
(1, 'Dev1'),
(2, 'Dev2'),
(3, 'Dev3');

-- --------------------------------------------------------

--
-- Structure de la table `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(50) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `course_name` (`course_name`),
  KEY `fk_courses_teachers` (`teacher_id`),
  KEY `fk_courses_classes` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `courses`
--

INSERT INTO `courses` (`course_id`, `course_name`, `teacher_id`, `class_id`) VALUES
(1, 'Data', 2, 1),
(2, 'GrapgQl', 1, 1),
(3, 'Devops', 3, 2),
(4, 'Mathematics', 4, 1),
(5, 'Api', 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `grades`
--

DROP TABLE IF EXISTS `grades`;
CREATE TABLE IF NOT EXISTS `grades` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `grade` int(11) DEFAULT NULL,
  PRIMARY KEY (`student_id`,`course_id`),
  KEY `fk_grades_courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `grades`
--

INSERT INTO `grades` (`student_id`, `course_id`, `grade`) VALUES
(1, 1, 13),
(1, 2, 8),
(1, 4, 11),
(2, 1, 20),
(2, 2, 10),
(2, 4, 5),
(3, 1, 17),
(3, 2, 20),
(3, 4, 19),
(6, 3, 12),
(6, 5, 20),
(7, 1, 14),
(7, 2, 20),
(7, 4, 12),
(8, 2, 16),
(9, 1, 12),
(9, 2, 20);

-- --------------------------------------------------------

--
-- Structure de la table `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `gender` enum('F','M') DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `unique_email_students` (`email`),
  KEY `fk_students_classes` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `students`
--

INSERT INTO `students` (`student_id`, `first_name`, `last_name`, `gender`, `class_id`, `email`) VALUES
(1, 'Domi', 'Li', 'M', 1, 'domi@gmail.com'),
(2, 'Lora', 'Han', 'F', 1, 'han@gmail.com'),
(3, 'Loo', 'Cas', 'F', 1, 'looca@gmail.com'),
(4, 'Sara', 'Morty', 'F', 3, 'mortyS@gmail.com'),
(5, 'Morgan', 'Fell', 'F', 3, 'morganF@gmail.com'),
(6, 'Louisa', 'Sitouah', 'F', 3, 'louisa@gmail.com'),
(7, 'Chels', 'Millo', 'M', 1, 'chel@gmail.com'),
(8, 'Quentin', 'Vitoux', 'M', 1, 'quent@gmail.com'),
(9, 'Will', 'Dorville', 'M', 1, 'will@gmail.com'),
(10, 'Maude', 'Mze', 'F', 1, 'maude@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
CREATE TABLE IF NOT EXISTS `teachers` (
  `teacher_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `gender` enum('F','M') DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `unique_email_teachers` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `first_name`, `last_name`, `gender`, `email`) VALUES
(1, 'Melvin', 'Bissor', 'M', 'melvinB@gmail.com'),
(2, 'Jana', 'Cuurts', 'F', 'janaC@gmail.com'),
(3, 'Lili', 'Petite', 'F', 'liliP@gmail.com'),
(4, 'Fenris', 'Merces', 'M', 'fenrisM@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
CREATE TABLE IF NOT EXISTS `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('1fab8760-1549-41f2-85fe-ebd08890aee6', 'e88e9a3fe667e371061fba6626da3969b6de736745da484a126c7f136fb029da', '2023-03-14 00:34:26.280', '0_init', '', NULL, '2023-03-14 00:34:26.280', 0);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`),
  ADD CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`),
  ADD CONSTRAINT `fk_courses_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`),
  ADD CONSTRAINT `fk_courses_teachers` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`);

--
-- Contraintes pour la table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `fk_grades_courses` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `fk_grades_students` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Contraintes pour la table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`),
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
