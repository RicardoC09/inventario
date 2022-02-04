-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-09-2021 a las 03:04:41
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario_documental1`
--

DELIMITER $$
--
-- Procedimientos
--

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_proceedings`(IN `id` INT)
    NO SQL
BEGIN
  DELETE FROM proceedings WHERE id = fileNumber;
  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_subproceedings`(IN `id` INT)
    NO SQL
BEGIN
  DELETE FROM sub_proceedings WHERE id = id;
  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_document`(IN `name` TEXT)
    NO SQL
BEGIN
  DELETE FROM documents WHERE name = name;
  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_consulta` (IN `_Sc` VARCHAR(191), IN `_Ss` VARCHAR(191), IN `_Se` VARCHAR(191), IN `_Sb` VARCHAR(191))  BEGIN
SELECT sc.name AS seccions, ss.name subSections, se.name AS serie, sb.name AS subSerie, pr.name AS proceedings, pr.description AS description, pr.state 
FROM proceedings pr
JOIN sub_series sb ON sb.id = pr.subSerieId
JOIN series se ON se.id = sb.serieId
JOIN sub_sections ss ON ss.id = se.subSectionId
JOIN seccions sc ON sc.id = ss.sectionId WHERE sc.name = @p0 AND  ss.name = @p1 AND se.name = @p2 AND sb.name = @p3;
SELECT IF(500<1000, "YES", "NO");
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_data_all` ()  NO SQL
BEGIN
SELECT pr.id AS id_proccedings, sc.name AS seccions,sc.id AS seccions_id, ss.name subSections, ss.sectionId AS sectionId, se.name AS serie, sb.name AS subSerie, pr.fileNumber AS numberProceedings, pr.name AS proceedings,pr.created_at AS proceedings_data, pr.description AS description,sp.name AS sub_proceedings,sp.created_at AS sub_proceedings_data, dc.name AS documents, dc.description AS descriptiondocuments,dc.created_at AS documents_data,dc.support AS documents_support, pr.state
FROM proceedings pr
JOIN documents dc ON dc.proceedingsId = pr.id
LEFT JOIN sub_proceedings sp ON sp.id = dc.subProceedingsId
JOIN sub_series sb ON sb.id = pr.subSerieId
JOIN series se ON se.id = sb.serieId
JOIN sub_sections ss ON ss.id = se.subSectionId
JOIN seccions sc ON sc.id = ss.sectionId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_document` ()  NO SQL
BEGIN
SELECT d.id AS documents_id, p.name AS proceedings, sp.name AS subproceedings, d.name AS documents, d.description, d.documentCreationDate AS date_document, d.state AS state, d.support AS support
FROM documents d
JOIN proceedings p ON p.id = d.proceedingsId
LEFT JOIN sub_proceedings sp ON sp.id = d.subProceedingsId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_document_types` ()  NO SQL
BEGIN
SELECT id, name FROM document_types;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_people_new` (IN `user_id` INT, IN `document_Type_id` INT, IN `document_Number` VARCHAR(255), IN `rol_id` INT, IN `position_id` INT, IN `avatar` VARCHAR(255))  NO SQL
BEGIN
INSERT INTO `people`(`user_id`, `document_Type_id`, `document_Number`, `rol_id`, `position_id`, `avatar`, `created_at`, `updated_at`) VALUES (user_id, document_Type_id, document_Number, rol_id, position_id, avatar, Now(), Now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_positions` ()  NO SQL
BEGIN
SELECT id, name FROM positions;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_proceedings` ()  NO SQL
BEGIN
SELECT id, name, fileNumber FROM proceedings;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_proceedings_all` ()  NO SQL
BEGIN
SELECT pr.id AS id_proccedings, sc.name AS seccions, ss.name subSections, se.name AS serie, sb.name AS subSerie, pr.fileNumber AS numberProceedings, pr.name AS proceedings, pr.description AS description, pr.state
FROM proceedings pr
JOIN sub_series sb ON sb.id = pr.subSerieId
JOIN series se ON se.id = sb.serieId
JOIN sub_sections ss ON ss.id = se.subSectionId
JOIN seccions sc ON sc.id = ss.sectionId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_roles` ()  NO SQL
BEGIN
SELECT id, name FROM roles;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_seccions` ()  NO SQL
BEGIN
SELECT * FROM seccions;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_seccion_all` ()  NO SQL
BEGIN
SELECT sc.id AS seccion_id, sc.name AS seccions ,sc.sectionCode AS seccion_code, ss.id AS subseccion_id, ss.name AS subseccion_name ,ss.subSectionCode AS subseccion_code,ss.sectionId AS subseccion_seccion
FROM sub_sections ss
LEFT JOIN seccions sc ON sc.id = ss.sectionId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_seccion_multi` ()  NO SQL
BEGIN
SELECT sc.id, sc.name,sc.sectionCode FROM seccions sc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_series` ()  NO SQL
BEGIN
SELECT* FROM series; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_serie_all` ()  NO SQL
BEGIN
SELECT se.id AS serie_id, se.name AS serie ,se.serieCode AS serie_code,se.subSectionId AS serie_subseccion, ss.id AS subseccion_id, ss.name AS subSections ,ss.subSectionCode AS subseccion_code,ss.sectionId AS subseccion_seccion
FROM series se
LEFT JOIN sub_sections ss ON ss.id = se.subSectionId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_SubProccedings` (IN `id` INT)  NO SQL
BEGIN
SELECT sp.id, sp.name, subFileNumber FROM sub_proceedings sp WHERE sp.proceedingsId = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_subproccedings_all` ()  NO SQL
BEGIN
SELECT sp.id AS sub_proceedings_id, p.name AS proceedings, sp.subFileNumber AS subfile_number, sp.name AS sub_proceedings, sp.description AS description, sp.state
FROM sub_proceedings sp
JOIN proceedings p ON p.id = sp.proceedingsId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_subseccion_multi` ()  NO SQL
BEGIN
SELECT ss.id, ss.name,ss.subSectionCode,ss.sectionId FROM sub_sections ss;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_subsections` ()  NO SQL
BEGIN 
SELECT * FROM sub_sections;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_subSerie` ()  NO SQL
BEGIN
SELECT sc.id AS seccions_id, sc.name AS seccions, ss.id AS sub_seccion_id,ss.sectionId AS sectionId, ss.name AS sub_seccion, s.id AS serie_id, s.name AS series, sbs.id AS sub_series_id, sbs.name AS sub_series, sc.sectionCode AS seccions_code, ss.subSectionCode as subsection_code, s.serieCode AS serie_code, sbs.subSerieCode AS subserie_code
FROM sub_series sbs
JOIN series s ON s.id = sbs.serieId
JOIN sub_sections ss ON ss.id = s.subSectionId
JOIN seccions sc ON sc.id = ss.sectionId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_subserie_all` ()  NO SQL
BEGIN
SELECT se.id AS serie_id, se.name AS serie ,se.serieCode AS serie_code,se.subSectionId AS serie_subseccion, sse.id AS subserie_id, sse.serieId AS subserie_serie, sse.subSerieCode AS subserie_code, sse.name AS subSerie
FROM sub_series sse
LEFT JOIN series se ON se.id = sse.serieId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user` (IN `idUser` INT)  NO SQL
BEGIN
SELECT pe.id AS idPeple, ro.id AS rolId, po.id AS cargo, us.name AS nameUser, dt.name AS taypeDocument, pe.document_Number AS number, ro.name AS rol, po.name AS position, us.email AS email, pe.avatar AS avatar
FROM people pe
JOIN users us ON pe.user_id = us.id
JOIN roles ro ON pe.rol_id = ro.id
JOIN document_types dt ON pe.document_Type_id = dt.id
JOIN positions po ON pe.position_id = po.id
WHERE pe.id = idUser;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users` ()  NO SQL
BEGIN
SELECT pe.id AS idPeple, us.name AS nameUser, dt.name AS taypeDocument, pe.document_Number AS number, ro.name AS rol, po.name AS position, us.email AS email, pe.avatar AS avatar
FROM people pe
JOIN users us ON pe.user_id = us.id
JOIN roles ro ON pe.rol_id = ro.id
JOIN document_types dt ON pe.document_Type_id = dt.id
JOIN positions po ON pe.position_id = po.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_document` (IN `user_id` INT, IN `proceedingsId` INT, IN `subProceedingsId` INT, IN `description` VARCHAR(255), IN `name` VARCHAR(255), IN `documentCreationDate` DATE, IN `support` VARCHAR(255), IN `state` VARCHAR(255))  NO SQL
BEGIN
INSERT INTO `documents`(`user_id`,`proceedingsId`, `subProceedingsId`, `description`, `name`, `documentCreationDate`, `support`, `state`, `created_at`, `updated_at`) VALUES (user_id, proceedingsId, subProceedingsId, description, name, documentCreationDate, support, state, Now(), Now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_proceedings` (IN `user_id` INT, IN `subSerieId` INT, IN `name` VARCHAR(250), IN `fileNumber` VARCHAR(250), IN `description` VARCHAR(250), IN `openingDate` DATE, IN `state` VARCHAR(250))  NO SQL
BEGIN
INSERT INTO proceedings (`user_id`,`subSerieId`, `name`, `fileNumber`, `description`, `openingDate`, `state`, `created_at`, `updated_at`) VALUES (user_id, subSerieId, name, fileNumber, description, openingDate, state, Now(), Now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_seccion` (IN `user_id` INT, IN `sectionCode` VARCHAR(191), IN `name` VARCHAR(191))  NO SQL
BEGIN
INSERT INTO seccions (`user_id`, `sectionCode`, `name`, `created_at`, `updated_at`) VALUES (user_id, sectionCode, name, Now(), Now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_serie` (IN `user_id` INT, IN `subSectionId` BIGINT(20), IN `serieCode` VARCHAR(191), IN `name` VARCHAR(191))  NO SQL
BEGIN
INSERT INTO series (`user_id`,`subSectionId`, `serieCode`,`name`, `created_at`, `updated_at`) VALUES (user_id,subSectionId, serieCode,name, Now(), Now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_SubProceedings` (IN `user_id` INT, IN `proceedingsId` INT, IN `name` VARCHAR(255), IN `subFileNumber` VARCHAR(255), IN `description` VARCHAR(255), IN `openingDate` DATE, IN `state` VARCHAR(255))  NO SQL
BEGIN
INSERT INTO `sub_proceedings`(`user_id`, `proceedingsId`, `name`, `subFileNumber`, `description`, `openingDate`, `state`, `created_at`, `updated_at`) VALUES (user_id, proceedingsId, name, subFileNumber, description, openingDate, state, Now(), Now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_subseccion` (IN `user_id` INT, IN `sectionId` BIGINT(20), IN `subSectionCode` VARCHAR(191), IN `name` VARCHAR(191))  NO SQL
BEGIN
INSERT INTO sub_sections (`user_id`,`sectionId`, `subSectionCode`,`name`, `created_at`, `updated_at`) VALUES (user_id, sectionId, subSectionCode,name, Now(), Now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_subserie` (IN `user_id` INT, IN `serieId` BIGINT(20), IN `subSerieCode` VARCHAR(191), IN `name` VARCHAR(191))  NO SQL
BEGIN
INSERT INTO sub_series (`user_id`,`serieId`, `subSerieCode`,`name`, `created_at`, `updated_at`) VALUES (user_id,serieId, subSerieCode,name, Now(), Now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_user_new` ()  NO SQL
BEGIN
INSERT INTO `users`(`name`, `email`, `password`, `created_at`, `updated_at`) VALUES (name, email, password, now(),NOw());
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documents`
--

CREATE TABLE `documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `proceedingsId` bigint(20) UNSIGNED NOT NULL,
  `subProceedingsId` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentCreationDate` date NOT NULL,
  `support` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` enum('Abierto','Cerrado','Privado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `document_types`
--

CREATE TABLE `document_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `document_types`
--

INSERT INTO `document_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Cédula de Ciudadanía', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 'Tarjeta de identidad', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(3, 'Tarjeta Pasaporte', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(4, 'Cédula de Extranjería', '2021-03-24 02:51:54', '2021-03-24 02:51:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(50, '2014_10_12_000000_create_users_table', 1),
(51, '2014_10_12_100000_create_password_resets_table', 1),
(52, '2019_08_19_000000_create_failed_jobs_table', 1),
(53, '2020_12_08_030031_create_document_types_table', 1),
(54, '2020_12_17_191404_create_seccions_table', 1),
(55, '2020_12_17_200322_create_sub_sections_table', 1),
(56, '2020_12_17_205636_create_series_table', 1),
(57, '2020_12_18_003253_create_sub_series_table', 1),
(58, '2020_12_19_134627_create_proceedings_table', 1),
(59, '2020_12_19_163813_create_sub_proceedings_table', 1),
(60, '2020_12_20_184229_create_documents_table', 1),
(61, '2021_03_11_045015_create_roles_table', 1),
(62, '2021_03_11_210204_create_positions_table', 1),
(63, '2021_03_11_210331_create_people_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `people`
--

CREATE TABLE `people` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `document_Type_id` bigint(20) UNSIGNED NOT NULL,
  `document_Number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol_id` bigint(20) UNSIGNED NOT NULL,
  `position_id` bigint(20) UNSIGNED NOT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `people`
--

INSERT INTO `people` (`id`, `user_id`, `document_Type_id`, `document_Number`, `rol_id`, `position_id`, `avatar`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '1075296095', 1, 5, '1-FotoUsuario-2021-03-23_04_48.jpeg', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 2, 1, '1075314686', 1, 1, '2-Foto-2021-09-26 19_40_12.png', '2021-09-27 00:40:12', '2021-09-27 00:40:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `positions`
--

CREATE TABLE `positions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `positions`
--

INSERT INTO `positions` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Desarrollador de software', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 'Secretaría Ejecutiva', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(3, 'Decano de Facultad', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(4, 'Secretaría de Facultad', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(5, 'Contratista', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(6, 'Asesora Academica', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(7, 'Asesora Juridica', '2021-03-24 02:51:54', '2021-03-24 02:51:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proceedings`
--

CREATE TABLE `proceedings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `subSerieId` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileNumber` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `openingDate` date NOT NULL,
  `deadline` date DEFAULT NULL,
  `state` enum('Público','Privado','Reservado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proceedings`
--

INSERT INTO `proceedings` (`id`, `user_id`, `subSerieId`, `name`, `fileNumber`, `description`, `openingDate`, `deadline`, `state`, `created_at`, `updated_at`) VALUES
(1, 1, 23, 'prueba', '1', 'prueba', '2021-09-20', NULL, 'Público', '2021-09-20 23:16:53', '2021-09-20 23:16:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Super Administrador', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 'Administrador', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(3, 'Usuario', '2021-03-24 02:51:54', '2021-03-24 02:51:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccions`
--

CREATE TABLE `seccions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `sectionCode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seccions`
--

INSERT INTO `seccions` (`id`, `user_id`, `sectionCode`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, '2', 'VICERRECTORIA ACADEMICA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 1, '2103', 'FACULTAD DE INGENIERIA', '2021-03-24 02:51:54', '2021-03-24 02:51:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `series`
--

CREATE TABLE `series` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `subSectionId` bigint(20) UNSIGNED NOT NULL,
  `serieCode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `series`
--

INSERT INTO `series` (`id`, `user_id`, `subSectionId`, `serieCode`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '21031', 'ACTAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 1, 1, '21032', 'INFORMES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(3, 1, 1, '21033', 'PLANES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(4, 1, 1, '21034', 'PROGRAMA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(5, 1, 1, '21035', 'PROYECTOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(6, 1, 2, '210311', 'ACTAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(7, 1, 2, '210312', 'INFORMES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(8, 1, 2, '210313', 'PLANES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(9, 1, 2, '210314', 'PROGRAMA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(10, 1, 2, '210315', 'PROYECTOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(11, 1, 3, '201321', 'ACTAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(12, 1, 3, '201322', 'INFORMES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(13, 1, 3, '201323', 'PLANES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(14, 1, 3, '201324', 'PROGRAMA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(15, 1, 3, '201325', 'PROYECTOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(16, 1, 4, '201331', 'ACTAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(17, 1, 4, '201332', 'INFORMES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(18, 1, 4, '201333', 'PLANES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(19, 1, 4, '201334', 'PROGRAMA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(20, 1, 4, '201335', 'PROYECTOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(21, 1, 5, '201341', 'ACTAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(22, 1, 5, '201342', 'INFORMES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(23, 1, 5, '201343', 'PLANES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(24, 1, 5, '201344', 'PROGRAMA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(25, 1, 5, '201345', 'PROYECTOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(26, 1, 5, '201351', 'ACTAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(27, 1, 6, '201352', 'INFORMES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(28, 1, 6, '201353', 'PLANES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(29, 1, 6, '201354', 'PROGRAMA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(30, 1, 6, '201355', 'PROYECTOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(31, 1, 7, '201361', 'ACTAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(32, 1, 7, '201362', 'INFORMES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(33, 1, 7, '201363', 'PLANES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(34, 1, 7, '201364', 'PROGRAMA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(35, 1, 7, '201365', 'PROYECTOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(36, 1, 8, '201371', 'ACTAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(37, 1, 8, '201372', 'INFORMES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(38, 1, 8, '201373', 'PLANES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(39, 1, 8, '201374', 'PROGRAMA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(40, 1, 8, '201375', 'PROYECTOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_proceedings`
--

CREATE TABLE `sub_proceedings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `proceedingsId` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subFileNumber` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `openingDate` date NOT NULL,
  `deadline` date DEFAULT NULL,
  `state` enum('Público','Privado','Reservado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_sections`
--

CREATE TABLE `sub_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `sectionId` bigint(20) UNSIGNED NOT NULL,
  `subSectionCode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sub_sections`
--

INSERT INTO `sub_sections` (`id`, `user_id`, `sectionId`, `subSectionCode`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2103', 'FACULTAD DE INGENIERIA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 1, 2, '20131', 'PROGRAMA INGENIERIA AGRICOLA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(3, 1, 2, '20132', 'PROGRAMA INGENIERIA DE PETROLEOS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(4, 1, 2, '20133', 'PROGRAMA TECNOLOGIA EN OBRAS CIVILES', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(5, 1, 2, '20134', 'PROGRAMA DE INGENIERIA ELECTRONICA', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(6, 1, 2, '20135', 'PROGRAMA DE TECNOLOGIA EN DESARROLLO DE SOFTWARE', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(7, 1, 2, '20136', 'PROGRAMA DE DOCTORADO EN CIENCIAS AGRARIAS', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(8, 1, 2, '20137', 'PROGRAMA DE ESPECIALIZACION EN INGENIERIA AMBIENTAL', '2021-03-24 02:51:54', '2021-03-24 02:51:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_series`
--

CREATE TABLE `sub_series` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `serieId` bigint(20) UNSIGNED NOT NULL,
  `subSerieCode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sub_series`
--

INSERT INTO `sub_series` (`id`, `user_id`, `serieId`, `subSerieCode`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '210311', 'ACTAS DE COMITE DE CURRICULO', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 1, 1, '210312', 'ACTAS DE COMITÉ DE PRACTICAS	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(3, 1, 1, '210313', 'ACTAS CONSEJO DE PROGRAMA	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(4, 1, 2, '210321', 'INFORMES A ENTES DE CONTROL	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(5, 1, 2, '210322', 'INFORMES INTERINSTITUCIONALES	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(6, 1, 2, '210323', 'INFORMES MONITOREO DE AGENDAS ACADEMICAS	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(7, 1, 3, '210331', 'PLANES DE ESTUDIO	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(8, 1, 4, '210341', 'MICRO DISEÑOS CURRICULARES	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(9, 1, 4, '210342', 'PROGRAMACION ACADEMICA	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(10, 1, 4, '210343', 'PROGRAMA DE CONSEJERIAS ACADEMICAS	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(11, 1, 5, '210351', 'PROYECTO DE ACREDITACION DE PROGRAMA ACADEMICO	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(12, 1, 6, '2103111', 'ACTAS DE COMITE DE CURRICULO	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(13, 1, 6, '2103112', 'ACTAS DE COMITÉ DE PRACTICAS	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(14, 1, 6, '2103113', 'ACTAS CONSEJO DE PROGRAMA	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(15, 1, 7, '2103122', 'INFORMES INTERINSTITUCIONALES	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(16, 1, 7, '2103121', 'INFORMES A ENTES DE CONTROL	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(17, 1, 7, '2103123', 'INFORMES MONITOREO DE AGENDAS ACADEMICAS	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(18, 1, 8, '2103131', 'PLANES DE ESTUDIO	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(19, 1, 9, '2103141', 'MICRO DISEÑOS CURRICULARES	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(20, 1, 9, '2103142', 'PROGRAMACION ACADEMICA	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(21, 1, 9, '2103143', 'PROGRAMA DE CONSEJERIAS ACADEMICAS	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(22, 1, 10, '2103151', 'PROYECTO DE ACREDITACION DE PROGRAMA ACADEMICO	', '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(23, 1, 11, '2013211', 'ACTAS DE COMITE DE CURRICULO', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(24, 1, 11, '2013212', 'ACTAS DE COMITÉ DE PRACTICAS', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(25, 1, 11, '2013213', 'ACTAS CONSEJO DE PROGRAMA', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(26, 1, 12, '2013221', 'INFORMES A ENTES DE CONTROL', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(27, 1, 12, '2013222', 'INFORMES INTERINSTITUCIONALES', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(28, 1, 12, '2013223', 'INFORMES MONITOREO DE AGENDAS ACADEMICAS', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(29, 1, 13, '2013231', 'PLANES DE ESTUDIO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(30, 1, 14, '2013241', 'MICRO DISEÑOS CURRICULARES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(31, 1, 14, '2013242', 'PROGRAMACION ACADEMICA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(32, 1, 14, '2013243', 'PROGRAMA DE CONSEJERIAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(33, 1, 15, '2013251', 'PROYECTO DE ACREDITACION DE PROGRAMA ACADEMICO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(34, 1, 16, '2013311', 'ACTAS DE COMITE DE CURRICULO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(35, 1, 16, '2013312', 'ACTAS DE COMITÉ DE PRACTICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(36, 1, 16, '2013313', 'ACTAS CONSEJO DE PROGRAMA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(37, 1, 17, '2013321', 'INFORMES A ENTES DE CONTROL	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(38, 1, 17, '2013322', 'INFORMES INTERINSTITUCIONALES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(39, 1, 17, '2013323', 'INFORMES MONITOREO DE AGENDAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(40, 1, 18, '2013333', 'PLANES DE ESTUDIO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(41, 1, 19, '2013341', 'MICRO DISEÑOS CURRICULARES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(42, 1, 19, '2013342', 'PROGRAMACION ACADEMICA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(43, 1, 19, '2013343', 'PROGRAMA DE CONSEJERIAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(44, 1, 20, '2013351', 'PROYECTO DE ACREDITACION DE PROGRAMA ACADEMICO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(45, 1, 21, '2013411', 'ACTAS DE COMITE DE CURRICULO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(46, 1, 21, '2013412', 'ACTAS DE COMITÉ DE PRACTICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(47, 1, 21, '2013413', 'ACTAS CONSEJO DE PROGRAMA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(48, 1, 22, '2013421', 'INFORMES A ENTES DE CONTROL	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(49, 1, 22, '2013422', 'INFORMES INTERINSTITUCIONALES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(50, 1, 22, '2013423', 'INFORMES MONITOREO DE AGENDAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(51, 1, 23, '2013431', 'PLANES DE ESTUDIO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(52, 1, 24, '2013441', 'MICRO DISEÑOS CURRICULARES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(53, 1, 24, '2013442', 'PROGRAMACION ACADEMICA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(54, 1, 24, '2013443', 'PROGRAMA DE CONSEJERIAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(55, 1, 25, '2013451', 'PROYECTO DE ACREDITACION DE PROGRAMA ACADEMICO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(56, 1, 26, '2013511', 'ACTAS DE COMITE DE CURRICULO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(57, 1, 26, '2013512', 'ACTAS DE COMITÉ DE PRACTICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(58, 1, 26, '2013513', 'ACTAS CONSEJO DE PROGRAMA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(59, 1, 27, '2013521', 'INFORMES A ENTES DE CONTROL	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(60, 1, 27, '2013522', 'INFORMES INTERINSTITUCIONALES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(61, 1, 27, '2013523', 'INFORMES MONITOREO DE AGENDAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(62, 1, 28, '2013531', 'PLANES DE ESTUDIO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(63, 1, 29, '2013541', 'MICRO DISEÑOS CURRICULARES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(64, 1, 29, '2013542', 'PROGRAMACION ACADEMICA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(65, 1, 29, '2013543', 'PROGRAMA DE CONSEJERIAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(66, 1, 30, '2013551', 'PROYECTO DE ACREDITACION DE PROGRAMA ACADEMICO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(67, 1, 31, '2013611', 'ACTAS DE COMITE DE CURRICULO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(68, 1, 31, '2013612', 'ACTAS DE COMITÉ DE PRACTICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(69, 1, 31, '2013613', 'ACTAS CONSEJO DE PROGRAMA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(70, 1, 32, '2013621', 'INFORMES A ENTES DE CONTROL	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(71, 1, 32, '2013622', 'INFORMES INTERINSTITUCIONALES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(72, 1, 32, '2013623', 'INFORMES MONITOREO DE AGENDAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(73, 1, 33, '2013631', 'PLANES DE ESTUDIO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(74, 1, 34, '2013641', 'MICRO DISEÑOS CURRICULARES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(75, 1, 34, '2013642', 'PROGRAMACION ACADEMICA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(76, 1, 34, '2013643', 'PROGRAMA DE CONSEJERIAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(77, 1, 35, '2013651', 'PROYECTO DE ACREDITACION DE PROGRAMA ACADEMICO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(78, 1, 36, '2013711', 'ACTAS DE COMITE DE CURRICULO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(79, 1, 36, '2013712', 'ACTAS DE COMITÉ DE PRACTICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(80, 1, 36, '2013713', 'ACTAS CONSEJO DE PROGRAMA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(81, 1, 37, '2013721', 'INFORMES A ENTES DE CONTROL	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(82, 1, 37, '2013722', 'INFORMES INTERINSTITUCIONALES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(83, 1, 37, '2013723', 'INFORMES MONITOREO DE AGENDAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(84, 1, 38, '2013731', 'PLANES DE ESTUDIO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(85, 1, 39, '2013741', 'MICRO DISEÑOS CURRICULARES	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(86, 1, 39, '2013742', 'PROGRAMACION ACADEMICA	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(87, 1, 39, '2013743', 'PROGRAMA DE CONSEJERIAS ACADEMICAS	', '2021-03-24 02:51:55', '2021-03-24 02:51:55'),
(88, 1, 40, '2013751', 'PROYECTO DE ACREDITACION DE PROGRAMA ACADEMICO	', '2021-03-24 02:51:55', '2021-03-24 02:51:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Verónica del Pilar Hurtado Cortés', 'veronica.hurtado@usco.edu.co', NULL, '$2y$10$DdgLZzajyEEiv1fKE8VEqOW86Ug4cKeFm9FKW/XGGhObVMw0akvQe', NULL, '2021-03-24 02:51:54', '2021-03-24 02:51:54'),
(2, 'Ricardo Cutiva', 'u20161149256@usco.edu.co', NULL, '$2y$10$Q.IuEPsmoqVQYs2w90l46Odh2sd/v2hwuK9nOhqejmAR3fwI06sz.', NULL, '2021-09-27 00:40:12', '2021-09-27 00:40:12');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documents_proceedingsid_foreign` (`proceedingsId`),
  ADD KEY `documents_subproceedingsid_foreign` (`subProceedingsId`),
  ADD KEY `documents_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`),
  ADD KEY `people_user_id_foreign` (`user_id`),
  ADD KEY `people_document_type_id_foreign` (`document_Type_id`),
  ADD KEY `people_rol_id_foreign` (`rol_id`),
  ADD KEY `people_position_id_foreign` (`position_id`);

--
-- Indices de la tabla `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proceedings`
--
ALTER TABLE `proceedings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proceedings_subserieid_foreign` (`subSerieId`),
  ADD KEY `proceedings_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `seccions`
--
ALTER TABLE `seccions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seccions_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`id`),
  ADD KEY `series_subsectionid_foreign` (`subSectionId`),
  ADD KEY `series_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `sub_proceedings`
--
ALTER TABLE `sub_proceedings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_proceedings_proceedingsid_foreign` (`proceedingsId`),
  ADD KEY `sub_proceedings_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `sub_sections`
--
ALTER TABLE `sub_sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_sections_sectionid_foreign` (`sectionId`),
  ADD KEY `sub_sections_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `sub_series`
--
ALTER TABLE `sub_series`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_series_serieid_foreign` (`serieId`),
  ADD KEY `sub_series_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `people`
--
ALTER TABLE `people`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `positions`
--
ALTER TABLE `positions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `proceedings`
--
ALTER TABLE `proceedings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `seccions`
--
ALTER TABLE `seccions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `series`
--
ALTER TABLE `series`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `sub_proceedings`
--
ALTER TABLE `sub_proceedings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sub_sections`
--
ALTER TABLE `sub_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `sub_series`
--
ALTER TABLE `sub_series`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_proceedingsid_foreign` FOREIGN KEY (`proceedingsId`) REFERENCES `proceedings` (`id`),
  ADD CONSTRAINT `documents_subproceedingsid_foreign` FOREIGN KEY (`subProceedingsId`) REFERENCES `sub_proceedings` (`id`),
  ADD CONSTRAINT `documents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `people`
--
ALTER TABLE `people`
  ADD CONSTRAINT `people_document_type_id_foreign` FOREIGN KEY (`document_Type_id`) REFERENCES `document_types` (`id`),
  ADD CONSTRAINT `people_position_id_foreign` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`),
  ADD CONSTRAINT `people_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `people_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `proceedings`
--
ALTER TABLE `proceedings`
  ADD CONSTRAINT `proceedings_subserieid_foreign` FOREIGN KEY (`subSerieId`) REFERENCES `sub_series` (`id`),
  ADD CONSTRAINT `proceedings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `seccions`
--
ALTER TABLE `seccions`
  ADD CONSTRAINT `seccions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `series`
--
ALTER TABLE `series`
  ADD CONSTRAINT `series_subsectionid_foreign` FOREIGN KEY (`subSectionId`) REFERENCES `sub_sections` (`id`),
  ADD CONSTRAINT `series_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `sub_proceedings`
--
ALTER TABLE `sub_proceedings`
  ADD CONSTRAINT `sub_proceedings_proceedingsid_foreign` FOREIGN KEY (`proceedingsId`) REFERENCES `proceedings` (`id`),
  ADD CONSTRAINT `sub_proceedings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `sub_sections`
--
ALTER TABLE `sub_sections`
  ADD CONSTRAINT `sub_sections_sectionid_foreign` FOREIGN KEY (`sectionId`) REFERENCES `seccions` (`id`),
  ADD CONSTRAINT `sub_sections_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `sub_series`
--
ALTER TABLE `sub_series`
  ADD CONSTRAINT `sub_series_serieid_foreign` FOREIGN KEY (`serieId`) REFERENCES `series` (`id`),
  ADD CONSTRAINT `sub_series_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
