-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 20 jan. 2024 à 23:21
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecommercedata`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse_facturation`
--

CREATE TABLE `adresse_facturation` (
  `id_adresse_facturation` int(11) NOT NULL,
  `rue` varchar(255) DEFAULT NULL COMMENT 'Rue de l''adresse',
  `ville` varchar(255) DEFAULT NULL COMMENT 'Ville de l''adresse',
  `code_postal` varchar(20) DEFAULT NULL COMMENT 'Code postal de l''adresse',
  `pays` varchar(255) DEFAULT NULL COMMENT 'Pays de l''adresse'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `adresse_facturation`
--

INSERT INTO `adresse_facturation` (`id_adresse_facturation`, `rue`, `ville`, `code_postal`, `pays`) VALUES
(1, '123 Rue de la Facturation', 'Villefacture', '12345', 'Paysfacture'),
(2, '456 Facture Street', 'Citybilling', '67890', 'Billingland'),
(3, '789 Rue de la Facturation', 'Autreville', '56789', 'Autrepays');

-- --------------------------------------------------------

--
-- Structure de la table `adresse_livraison`
--

CREATE TABLE `adresse_livraison` (
  `id_adresse_livraison` int(11) NOT NULL,
  `rue` varchar(255) DEFAULT NULL COMMENT 'Rue de l''adresse',
  `ville` varchar(255) DEFAULT NULL COMMENT 'Ville de l''adresse',
  `code_postal` varchar(20) DEFAULT NULL COMMENT 'Code postal de l''adresse',
  `pays` varchar(255) DEFAULT NULL COMMENT 'Pays de l''adresse'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `adresse_livraison`
--

INSERT INTO `adresse_livraison` (`id_adresse_livraison`, `rue`, `ville`, `code_postal`, `pays`) VALUES
(1, '123 Rue de la Livraison', 'Ville Livrée', '12345', 'Pays Livré'),
(2, '456 Avenue Express', 'Autre Ville', '67890', 'Pays Express'),
(3, '789 Rue Rapide', 'Ville Rapide', '54321', 'Pays Rapide');

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id_categorie` int(11) NOT NULL,
  `nom_categorie` varchar(255) NOT NULL COMMENT 'Nom de la catégorie',
  `description` text DEFAULT NULL COMMENT 'Description de la catégorie',
  `url_image` varchar(255) DEFAULT NULL COMMENT 'URL de l''image de la catégorie',
  `statut` enum('actif','inactif') NOT NULL COMMENT 'Statut de la catégorie (actif ou inactif)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id_categorie`, `nom_categorie`, `description`, `url_image`, `statut`) VALUES
(1, 'Électronique', 'Produits électroniques de pointe', 'url_image_electronique.jpg', 'actif'),
(2, 'Vêtements', 'Dernières tendances de la mode', 'url_image_vetements.jpg', 'actif'),
(3, 'Maison et Jardin', 'Articles pour la maison et le jardin', 'url_image_maison.jpg', 'actif'),
(4, 'Santé et Beauté', 'Produits de santé et de beauté', 'url_image_sante.jpg', 'actif'),
(5, 'Sport et Loisirs', 'Équipements sportifs et articles de loisirs', 'url_image_sport.jpg', 'actif'),
(6, 'Livres et Musique', 'Livres et musique pour tous les goûts', 'url_image_livres.jpg', 'actif'),
(7, 'Alimentation et Boissons', 'Produits alimentaires et boissons de qualité', 'url_image_alimentation.jpg', 'actif'),
(8, 'Informatique', 'Matériel informatique et logiciels', 'url_image_informatique.jpg', 'actif'),
(9, 'Accessoires de Mode', 'Accessoires tendance pour tous les styles', 'url_image_accessoires.jpg', 'actif'),
(10, 'Art et Artisanat', 'Œuvres d\'art et créations artisanales', 'url_image_art.jpg', 'actif');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

CREATE TABLE `commandes` (
  `id_commande` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL COMMENT 'ID de l''utilisateur associé',
  `date_commande` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date de la commande',
  `statut_commande` enum('en_cours','expediee','livree','annulee') NOT NULL COMMENT 'Statut de la commande',
  `montant_total` decimal(10,2) NOT NULL COMMENT 'Montant total de la commande',
  `methode_paiement` varchar(255) DEFAULT NULL COMMENT 'Méthode de paiement',
  `id_adresse_livraison` int(11) NOT NULL COMMENT 'ID de l''adresse de livraison',
  `id_adresse_facturation` int(11) NOT NULL COMMENT 'ID de l''adresse de facturation',
  `details_produits` text DEFAULT NULL COMMENT 'Détails des produits de la commande (au format JSON)',
  `numero_suivi` varchar(255) DEFAULT NULL COMMENT 'Numéro de suivi de la commande',
  `notes_speciales` text DEFAULT NULL COMMENT 'Notes spéciales sur la commande',
  `statut_paiement` enum('paye','en_attente','echec','remboursement') NOT NULL COMMENT 'Statut du paiement',
  `code_promo` varchar(255) DEFAULT NULL COMMENT 'Code de promotion (s''il y en a)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`id_commande`, `id_utilisateur`, `date_commande`, `statut_commande`, `montant_total`, `methode_paiement`, `id_adresse_livraison`, `id_adresse_facturation`, `details_produits`, `numero_suivi`, `notes_speciales`, `statut_paiement`, `code_promo`) VALUES
(1, 1, '2024-01-10 07:30:00', 'expediee', 120.00, 'Carte de crédit', 1, 2, '[{\"id_produit\": 1, \"nom_produit\": \"Produit A\", \"quantite\": 2}, {\"id_produit\": 2, \"nom_produit\": \"Produit B\", \"quantite\": 1}]', 'SU123456', 'Aucune', 'paye', 'CODE123'),
(2, 2, '2024-02-05 11:15:00', 'livree', 80.50, 'PayPal', 3, 3, '[{\"id_produit\": 3, \"nom_produit\": \"Produit C\", \"quantite\": 1}]', 'SU789012', 'Emballage cadeau inclus', 'paye', NULL),
(3, 1, '2024-02-20 09:45:00', 'en_cours', 50.20, 'Virement bancaire', 2, 1, '[{\"id_produit\": 4, \"nom_produit\": \"Produit D\", \"quantite\": 3}]', 'SU345678', 'Aucune', 'en_attente', NULL),
(4, 3, '2024-03-08 14:30:00', 'en_cours', 110.75, 'Carte de débit', 1, 2, '[{\"id_produit\": 5, \"nom_produit\": \"Produit E\", \"quantite\": 2}, {\"id_produit\": 6, \"nom_produit\": \"Produit F\", \"quantite\": 1}]', 'SU901234', 'Livraison express', 'en_attente', 'PROMO25');

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

CREATE TABLE `commentaires` (
  `id_commentaire` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `id_produit` int(11) DEFAULT NULL COMMENT 'ID du produit associé',
  `note` decimal(3,2) DEFAULT NULL COMMENT 'Note du commentaire',
  `contenu_commentaire` text DEFAULT NULL COMMENT 'Contenu du commentaire',
  `date_commentaire` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date du commentaire',
  `statut` enum('actif','modere','cache') NOT NULL COMMENT 'Statut du commentaire (actif, modéré ou caché)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commentaires`
--

INSERT INTO `commentaires` (`id_commentaire`, `id_utilisateur`, `id_produit`, `note`, `contenu_commentaire`, `date_commentaire`, `statut`) VALUES
(1, 1, 1, 4.50, 'Excellent produit, je le recommande vivement !', '2024-01-15 13:20:00', 'actif'),
(2, 2, 3, 3.20, 'Bon rapport qualité-prix.', '2024-02-02 08:45:00', 'actif'),
(3, 3, 5, 5.00, 'Magnifique !', '2024-02-25 17:10:00', 'actif'),
(4, 4, 2, 2.80, 'Déçu par la qualité du produit.', '2024-03-10 10:30:00', 'modere'),
(5, 1, 4, 4.00, 'Très bon service client.', '2024-03-20 15:50:00', 'cache'),
(6, 3, 6, 4.70, 'Livraison rapide, produit conforme à la description.', '2024-04-05 06:15:00', 'actif');

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

CREATE TABLE `factures` (
  `id_facture` int(11) NOT NULL,
  `id_commande` int(11) DEFAULT NULL COMMENT 'ID de la commande associée',
  `montant_total` decimal(10,2) NOT NULL COMMENT 'Montant total de la facture',
  `date_facture` date NOT NULL COMMENT 'Date de la facture'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `factures`
--

INSERT INTO `factures` (`id_facture`, `id_commande`, `montant_total`, `date_facture`) VALUES
(1, 1, 120.50, '2024-01-20'),
(2, 2, 89.99, '2024-02-05'),
(3, 3, 200.00, '2024-02-28'),
(4, 4, 45.75, '2024-03-15'),
(5, 1, 150.00, '2024-03-25'),
(6, 2, 75.49, '2024-04-10');

-- --------------------------------------------------------

--
-- Structure de la table `historique_achats`
--

CREATE TABLE `historique_achats` (
  `id_achat` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `achats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Détails des achats (au format JSON)' CHECK (json_valid(`achats`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `historique_achats`
--

INSERT INTO `historique_achats` (`id_achat`, `id_utilisateur`, `achats`) VALUES
(1, 1, '[{\"id_achat\": 201, \"date_achat\": \"2024-01-10\", \"montant_achat\": 120.00, \"produits\": [{\"id_produit\": 1, \"nom_produit\": \"Produit A\", \"quantite\": 2}, {\"id_produit\": 2, \"nom_produit\": \"Produit B\", \"quantite\": 1}]}, {\"id_achat\": 202, \"date_achat\": \"2024-02-05\", \"montant_achat\": 80.50, \"produits\": [{\"id_produit\": 3, \"nom_produit\": \"Produit C\", \"quantite\": 1}]}]'),
(2, 2, '[{\"id_achat\": 203, \"date_achat\": \"2024-01-15\", \"montant_achat\": 50.20, \"produits\": [{\"id_produit\": 4, \"nom_produit\": \"Produit D\", \"quantite\": 3}]}, {\"id_achat\": 204, \"date_achat\": \"2024-02-12\", \"montant_achat\": 110.75, \"produits\": [{\"id_produit\": 5, \"nom_produit\": \"Produit E\", \"quantite\": 2}, {\"id_produit\": 6, \"nom_produit\": \"Produit F\", \"quantite\": 1}]}]');

-- --------------------------------------------------------

--
-- Structure de la table `historique_commandes`
--

CREATE TABLE `historique_commandes` (
  `id_histo_commande` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `commandes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Détails des commandes (au format JSON)' CHECK (json_valid(`commandes`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `historique_commandes`
--

INSERT INTO `historique_commandes` (`id_histo_commande`, `id_utilisateur`, `commandes`) VALUES
(1, 1, '[{\"id_commande\": 101, \"date_commande\": \"2024-01-20\", \"montant_total\": 150.00, \"statut_commande\": \"livree\"}, {\"id_commande\": 102, \"date_commande\": \"2024-02-15\", \"montant_total\": 200.50, \"statut_commande\": \"expediee\"}]'),
(2, 2, '[{\"id_commande\": 103, \"date_commande\": \"2024-01-22\", \"montant_total\": 75.80, \"statut_commande\": \"livree\"}, {\"id_commande\": 104, \"date_commande\": \"2024-02-18\", \"montant_total\": 120.25, \"statut_commande\": \"expediee\"}]');

-- --------------------------------------------------------

--
-- Structure de la table `historique_navigation`
--

CREATE TABLE `historique_navigation` (
  `id_historique` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `page_visitee` varchar(255) NOT NULL COMMENT 'Page visitée par l''utilisateur',
  `date_visite` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date de la visite'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `historique_navigation`
--

INSERT INTO `historique_navigation` (`id_historique`, `id_utilisateur`, `page_visitee`, `date_visite`) VALUES
(1, 1, 'Accueil', '2024-01-20 09:15:00'),
(2, 1, 'Produits', '2024-01-20 10:30:00'),
(3, 1, 'Panier', '2024-01-20 11:45:00'),
(4, 2, 'Accueil', '2024-01-21 08:00:00'),
(5, 2, 'Produits', '2024-01-21 09:20:00'),
(6, 2, 'Commandes', '2024-01-21 10:45:00');

-- --------------------------------------------------------

--
-- Structure de la table `historique_paiements`
--

CREATE TABLE `historique_paiements` (
  `id_histo_paiement` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `paiements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Détails des paiements (au format JSON)' CHECK (json_valid(`paiements`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `historique_paiements`
--

INSERT INTO `historique_paiements` (`id_histo_paiement`, `id_utilisateur`, `paiements`) VALUES
(1, 1, '{\"paiements\":[{\"id_paiement\": 1, \"montant\": 50.00, \"date\": \"2024-01-20 14:30:00\", \"methode\": \"Carte de crédit\", \"statut\": \"paye\"},{\"id_paiement\": 2, \"montant\": 75.50, \"date\": \"2024-01-21 10:45:00\", \"methode\": \"PayPal\", \"statut\": \"paye\"}]}'),
(2, 2, '{\"paiements\":[{\"id_paiement\": 3, \"montant\": 30.20, \"date\": \"2024-01-22 09:15:00\", \"methode\": \"Virement bancaire\", \"statut\": \"en_attente\"},{\"id_paiement\": 4, \"montant\": 95.75, \"date\": \"2024-01-23 16:20:00\", \"methode\": \"Carte de débit\", \"statut\": \"echec\"},{\"id_paiement\": 5, \"montant\": 60.00, \"date\": \"2024-01-24 12:10:00\", \"methode\": \"PayPal\", \"statut\": \"paye\"}]}');

-- --------------------------------------------------------

--
-- Structure de la table `methodes_authentification`
--

CREATE TABLE `methodes_authentification` (
  `id_methode` int(11) NOT NULL,
  `nom_methode` varchar(50) NOT NULL COMMENT 'Nom de la méthode d''authentification'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `methodes_authentification`
--

INSERT INTO `methodes_authentification` (`id_methode`, `nom_methode`) VALUES
(1, 'Authentification par mot de passe'),
(2, 'Authentification à deux facteurs (2FA)'),
(3, 'Reconnaissance faciale'),
(4, 'Empreinte digitale'),
(5, 'Authentification par e-mail');

-- --------------------------------------------------------

--
-- Structure de la table `paiements`
--

CREATE TABLE `paiements` (
  `id_paiement` int(11) NOT NULL,
  `id_commande` int(11) DEFAULT NULL COMMENT 'ID de la commande associée',
  `methode_paiement` varchar(255) NOT NULL COMMENT 'Méthode de paiement',
  `montant` decimal(10,2) NOT NULL COMMENT 'Montant du paiement',
  `date_paiement` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date du paiement',
  `statut_paiement` enum('paye','en_attente','echec','remboursement') NOT NULL COMMENT 'Statut du paiement',
  `details_paiement` text DEFAULT NULL COMMENT 'Détails du paiement (au format JSON)',
  `id_facture` int(11) DEFAULT NULL COMMENT 'ID de la facture associée'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `paiements`
--

INSERT INTO `paiements` (`id_paiement`, `id_commande`, `methode_paiement`, `montant`, `date_paiement`, `statut_paiement`, `details_paiement`, `id_facture`) VALUES
(1, 1, 'Carte de crédit', 120.50, '2024-01-21 07:30:00', 'paye', '{\"transaction_id\": \"ABC123\"}', 1),
(2, 2, 'PayPal', 89.99, '2024-02-05 14:45:00', 'paye', '{\"transaction_id\": \"XYZ789\"}', 2),
(3, 3, 'Virement bancaire', 200.00, '2024-03-01 09:15:00', 'paye', '{\"reference\": \"BANK123\"}', 3),
(4, 4, 'Carte de débit', 45.75, '2024-03-16 11:00:00', 'en_attente', NULL, 4),
(5, 1, 'Apple Pay', 150.00, '2024-03-26 13:20:00', 'echec', '{\"error_message\": \"Fonds insuffisants\"}', 5),
(6, 2, 'Carte de crédit', 75.49, '2024-04-11 07:55:00', 'remboursement', '{\"reason\": \"Retour de produit\"}', 6);

-- --------------------------------------------------------

--
-- Structure de la table `paniers`
--

CREATE TABLE `paniers` (
  `id_panier` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `montant_total` decimal(10,2) DEFAULT NULL COMMENT 'Montant total du panier',
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date de création du panier',
  `statut` enum('actif','abandonne','finalise') NOT NULL COMMENT 'Statut du panier (actif, abandonné ou finalisé)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `paniers`
--

INSERT INTO `paniers` (`id_panier`, `id_utilisateur`, `montant_total`, `date_creation`, `statut`) VALUES
(1, 1, 150.00, '2024-01-20 22:05:12', 'actif'),
(2, 2, 200.50, '2024-01-20 22:05:12', 'finalise'),
(3, 3, 50.20, '2024-01-20 22:05:12', 'abandonne'),
(4, 4, 120.75, '2024-01-20 22:05:12', 'finalise'),
(5, 5, 90.00, '2024-01-20 22:05:12', 'actif');

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

CREATE TABLE `produits` (
  `id_produit` int(11) NOT NULL,
  `nom_produit` varchar(255) NOT NULL COMMENT 'Nom du produit',
  `description` text DEFAULT NULL COMMENT 'Description du produit',
  `id_categorie` int(11) DEFAULT NULL COMMENT 'ID de la catégorie du produit',
  `id_sous_categorie` int(11) DEFAULT NULL COMMENT 'ID de la sous-catégorie du produit',
  `prix` decimal(10,2) NOT NULL COMMENT 'Prix du produit',
  `disponibilite` int(11) NOT NULL COMMENT 'Disponibilité du produit',
  `images` text DEFAULT NULL COMMENT 'URL des images du produit (au format JSON)',
  `caracteristiques` text DEFAULT NULL COMMENT 'Caractéristiques du produit (au format JSON)',
  `marque` varchar(255) DEFAULT NULL COMMENT 'Marque du produit',
  `notes` decimal(3,2) DEFAULT NULL COMMENT 'Notes du produit',
  `quantite_stock` int(11) DEFAULT NULL COMMENT 'Quantité en stock',
  `fournisseur` varchar(255) DEFAULT NULL COMMENT 'Fournisseur du produit',
  `statut` enum('actif','inactif') NOT NULL COMMENT 'Statut du produit (actif ou inactif)',
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date de création du produit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id_produit`, `nom_produit`, `description`, `id_categorie`, `id_sous_categorie`, `prix`, `disponibilite`, `images`, `caracteristiques`, `marque`, `notes`, `quantite_stock`, `fournisseur`, `statut`, `date_creation`) VALUES
(1, 'Smartphone XYZ', 'Un smartphone haut de gamme avec des fonctionnalités avancées.', 1, NULL, 899.99, 50, '[image1.jpg, image2.jpg]', '[4G, écran AMOLED, caméra 48MP]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:16'),
(2, 'Ordinateur Portable ABC', 'Un ordinateur portable puissant pour les professionnels.', 1, NULL, 1299.99, 30, '[image3.jpg, image4.jpg]', '[Intel i7, 16 Go RAM, SSD 512 Go]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:16'),
(3, 'Écouteurs Bluetooth DEF', 'Des écouteurs sans fil pour une expérience audio immersive.', 1, NULL, 99.99, 100, '[image5.jpg, image6.jpg]', '[Bluetooth 5.0, autonomie 20 heures]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:16'),
(4, 'Chemise Rayée XYZ', 'Une chemise élégante pour toutes les occasions.', 2, NULL, 49.99, 80, '[image7.jpg, image8.jpg]', '[Matériau coton, taille disponible]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:16'),
(5, 'Chaussures de Sport ABC', 'Chaussures de sport confortables pour une activité physique intense.', 2, NULL, 79.99, 40, '[image9.jpg, image10.jpg]', '[Tailles variées, semelle antidérapante]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:16'),
(6, 'Sac à Main DEF', 'Un sac à main élégant pour compléter votre look.', 2, NULL, 129.99, 20, '[image11.jpg, image12.jpg]', '[Cuir de haute qualité, multiples compartiments]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:16'),
(7, 'Ensemble de Cuisine XYZ', 'Un ensemble complet pour équiper votre cuisine.', 3, NULL, 199.99, 30, '[image13.jpg, image14.jpg]', '[Acier inoxydable, 10 pièces]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(8, 'Tondeuse à Gazon ABC', 'Une tondeuse puissante pour entretenir votre jardin.', 3, NULL, 299.99, 15, '[image15.jpg, image16.jpg]', '[Moteur 2000W, coupe réglable]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(9, 'Coussins Décoratifs DEF', 'Des coussins élégants pour ajouter une touche de confort à votre intérieur.', 3, NULL, 39.99, 50, '[image17.jpg, image18.jpg]', '[Différents motifs disponibles]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(10, 'Roman Mystère XYZ', 'Un roman captivant rempli de mystères.', 4, NULL, 19.99, 100, '[image19.jpg, image20.jpg]', '[Auteur renommé, 300 pages]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(11, 'Guide Culinaire ABC', 'Un guide pratique pour explorer l\'art de la cuisine.', 4, NULL, 29.99, 80, '[image21.jpg, image22.jpg]', '[Recettes variées, conseils culinaires]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(12, 'Livre pour Enfants DEF', 'Un livre illustré pour divertir et éduquer les plus jeunes.', 4, NULL, 14.99, 120, '[image23.jpg, image24.jpg]', '[Pages en carton, adapté aux enfants]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(13, 'Smartphone XYZ', 'Un smartphone dernier cri avec des fonctionnalités avancées.', 1, NULL, 699.99, 50, '[image25.jpg, image26.jpg]', '[Écran AMOLED, Caméra 64MP]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(14, 'Ordinateur Portable ABC', 'Un ordinateur portable puissant pour répondre à vos besoins informatiques.', 1, NULL, 1299.99, 30, '[image27.jpg, image28.jpg]', '[Processeur Intel i7, 16 Go RAM]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(15, 'Écouteurs Bluetooth DEF', 'Des écouteurs sans fil avec une qualité audio exceptionnelle.', 1, NULL, 79.99, 80, '[image29.jpg, image30.jpg]', '[Bluetooth 5.0, Autonomie 10 heures]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(16, 'Chemise Formelle XYZ', 'Une chemise élégante pour les occasions spéciales.', 2, NULL, 49.99, 60, '[image31.jpg, image32.jpg]', '[Taille M, Couleur blanche]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(17, 'Jeans Décontractés ABC', 'Des jeans confortables pour un style décontracté.', 2, NULL, 39.99, 75, '[image33.jpg, image34.jpg]', '[Taille 32, Couleur bleue]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(18, 'Robe de Soirée DEF', 'Une robe chic pour briller lors de soirées spéciales.', 2, NULL, 89.99, 40, '[image35.jpg, image36.jpg]', '[Taille S, Couleur noire]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(19, 'Tapis de Yoga XYZ', 'Un tapis de yoga antidérapant pour vos séances de méditation.', 5, NULL, 29.99, 90, '[image37.jpg, image38.jpg]', '[Épaisseur 5mm, Matériau écologique]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(20, 'Raquette de Tennis ABC', 'Une raquette de tennis professionnelle pour les passionnés.', 5, NULL, 119.99, 20, '[image39.jpg, image40.jpg]', '[Matériau en carbone, Poids 300g]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(21, 'Vélo de Montagne DEF', 'Un vélo robuste pour les aventures en plein air.', 5, NULL, 499.99, 15, '[image41.jpg, image42.jpg]', '[21 vitesses, Suspension avant]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(22, 'Ensemble de Literie XYZ', 'Un ensemble de literie élégant pour une chambre confortable.', 3, NULL, 79.99, 45, '[image43.jpg, image44.jpg]', '[Taille Queen, Matériau en coton]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(23, 'Tondeuse à Gazon ABC', 'Une tondeuse à gazon électrique pour entretenir votre pelouse.', 3, NULL, 199.99, 25, '[image45.jpg, image46.jpg]', '[Puissance 1500W, Largeur de coupe 40cm]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(24, 'Ensemble de Salle à Manger DEF', 'Un ensemble de salle à manger moderne pour votre espace repas.', 3, NULL, 499.99, 10, '[image47.jpg, image48.jpg]', '[Table avec 4 chaises, Matériau en bois]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:17'),
(25, 'Roman Best-Seller XYZ', 'Un roman captivant écrit par un auteur renommé.', 4, NULL, 24.99, 70, '[image49.jpg, image50.jpg]', '[Auteur célèbre, 400 pages]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(26, 'Collection de Films Classiques ABC', 'Une collection de films classiques en édition spéciale.', 4, NULL, 89.99, 50, '[image51.jpg, image52.jpg]', '[10 DVD, Langues multiples]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(27, 'Livre de Cuisine DEF', 'Un livre de cuisine avec des recettes délicieuses et faciles à préparer.', 4, NULL, 19.99, 60, '[image53.jpg, image54.jpg]', '[100 recettes, Couverture rigide]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(28, 'Ensemble de Meubles de Jardin', 'Un ensemble de meubles de jardin élégants pour vos espaces extérieurs.', 3, NULL, 699.99, 15, '[image67.jpg, image68.jpg]', '[Table avec 4 chaises, Résistant aux intempéries]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(29, 'Lampe de Salon Moderne', 'Une lampe de salon au design moderne pour éclairer votre espace de vie.', 3, NULL, 129.99, 35, '[image69.jpg, image70.jpg]', '[Abat-jour en tissu, Socle en métal]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(30, 'Coussins Décoratifs', 'Des coussins décoratifs pour ajouter une touche de couleur à votre canapé.', 3, NULL, 29.99, 50, '[image71.jpg, image72.jpg]', '[Ensemble de 3, Housse en lin]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(31, 'Best-seller du Mois', 'Le dernier best-seller qui captivera votre imagination.', 4, NULL, 19.99, 100, '[image73.jpg, image74.jpg]', '[Auteur renommé, 300 pages]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(32, 'Collection de CD Classique', 'Une collection de CD avec des chefs-d\'œuvre de la musique classique.', 4, NULL, 59.99, 25, '[image75.jpg, image76.jpg]', '[Coffret de 10 CD]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(33, 'Guitare Acoustique Professionnelle', 'Une guitare acoustique de qualité professionnelle pour les amateurs de musique.', 4, NULL, 299.99, 10, '[image77.jpg, image78.jpg]', '[Corps en épicéa, Manche en érable]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(34, 'Tapis de Yoga Antidérapant', 'Un tapis de yoga confortable et antidérapant pour vos séances de yoga.', 5, NULL, 39.99, 40, '[image79.jpg, image80.jpg]', '[Épaisseur 6 mm, Matériau écologique]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(35, 'Vélo de Montagne Haut de Gamme', 'Un vélo de montagne robuste pour les amateurs de plein air.', 5, NULL, 699.99, 12, '[image81.jpg, image82.jpg]', '[Cadre en aluminium, 21 vitesses]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18'),
(36, 'Ensemble de Raquettes de Tennis', 'Un ensemble de raquettes de tennis de qualité pour des parties passionnantes.', 5, NULL, 89.99, 20, '[image83.jpg, image84.jpg]', '[Lot de 2 raquettes avec balles]', NULL, NULL, NULL, NULL, 'actif', '2024-01-20 21:07:18');

-- --------------------------------------------------------

--
-- Structure de la table `promotions`
--

CREATE TABLE `promotions` (
  `id_promotion` int(11) NOT NULL,
  `code_promo` varchar(255) NOT NULL COMMENT 'Code de promotion',
  `reduction` decimal(5,2) NOT NULL COMMENT 'Montant de réduction de la promotion',
  `date_expiration` date DEFAULT NULL COMMENT 'Date d''expiration de la promotion',
  `utilisation_unique` enum('oui','non') NOT NULL COMMENT 'Indique si le code de promotion est à usage unique (oui ou non)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `promotions`
--

INSERT INTO `promotions` (`id_promotion`, `code_promo`, `reduction`, `date_expiration`, `utilisation_unique`) VALUES
(1, 'SUMMER10', 10.00, '2024-08-31', 'oui'),
(2, 'FREESHIP', 5.00, '2024-09-15', 'non'),
(3, 'SALE20', 20.00, '2024-08-20', 'oui'),
(4, 'NEWUSER15', 15.00, '2024-10-01', 'oui'),
(5, 'HOLIDAY25', 25.00, '2024-12-31', 'non');

-- --------------------------------------------------------

--
-- Structure de la table `sous_categories`
--

CREATE TABLE `sous_categories` (
  `id_sous_categorie` int(11) NOT NULL,
  `nom_sous_categorie` varchar(255) NOT NULL COMMENT 'Nom de la sous-catégorie',
  `description` text DEFAULT NULL COMMENT 'Description de la sous-catégorie',
  `id_categorie` int(11) DEFAULT NULL COMMENT 'ID de la catégorie parente',
  `url_image` varchar(255) DEFAULT NULL COMMENT 'URL de l''image de la sous-catégorie',
  `statut` enum('actif','inactif') NOT NULL COMMENT 'Statut de la sous-catégorie (actif ou inactif)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sous_categories`
--

INSERT INTO `sous_categories` (`id_sous_categorie`, `nom_sous_categorie`, `description`, `id_categorie`, `url_image`, `statut`) VALUES
(1, 'Smartphones', 'Derniers modèles de smartphones', 1, 'url_image_smartphones.jpg', 'actif'),
(2, 'Ordinateurs portables', 'Ordinateurs portables performants', 1, 'url_image_laptops.jpg', 'actif'),
(3, 'Hommes', 'Vêtements pour hommes tendance', 2, 'url_image_vetements_hommes.jpg', 'actif'),
(4, 'Femmes', 'Vêtements pour femmes élégants', 2, 'url_image_vetements_femmes.jpg', 'actif'),
(5, 'Meubles', 'Meubles pour toutes les pièces', 3, 'url_image_meubles.jpg', 'actif'),
(6, 'Jardinage', 'Outils et accessoires de jardinage', 3, 'url_image_jardinage.jpg', 'actif'),
(7, 'Soins du visage', 'Produits pour les soins du visage', 4, 'url_image_soins_visage.jpg', 'actif'),
(8, 'Fitness', 'Équipements de fitness et suppléments', 4, 'url_image_fitness.jpg', 'actif'),
(9, 'Sports d\'équipe', 'Équipements pour sports d\'équipe', 5, 'url_image_sports_equipe.jpg', 'actif'),
(10, 'Loisirs créatifs', 'Matériaux pour loisirs créatifs', 5, 'url_image_loisirs_creatifs.jpg', 'actif'),
(11, 'Livres de fiction', 'Romans et histoires captivantes', 6, 'url_image_livres_fiction.jpg', 'actif'),
(12, 'Instruments de musique', 'Instruments pour musiciens amateurs et professionnels', 6, 'url_image_instruments_musique.jpg', 'actif'),
(13, 'Épicerie fine', 'Produits d\'épicerie de qualité', 7, 'url_image_epicerie_fine.jpg', 'actif'),
(14, 'Vins et Spiritueux', 'Sélection de vins et spiritueux', 7, 'url_image_vins_spiritueux.jpg', 'actif'),
(15, 'Accessoires informatiques', 'Accessoires utiles pour ordinateurs', 8, 'url_image_accessoires_informatiques.jpg', 'actif'),
(16, 'Logiciels', 'Logiciels pour divers besoins', 8, 'url_image_logiciels.jpg', 'actif'),
(17, 'Sacs à main', 'Sacs élégants pour toutes les occasions', 9, 'url_image_sacs_main.jpg', 'actif'),
(18, 'Bijoux', 'Bijoux tendance pour hommes et femmes', 9, 'url_image_bijoux.jpg', 'actif'),
(19, 'Peinture', 'Matériel de peinture et toiles', 10, 'url_image_peinture.jpg', 'actif'),
(20, 'Artisanat fait main', 'Articles faits main uniques', 10, 'url_image_artisanat.jpg', 'actif');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `id_utilisateur` int(11) NOT NULL,
  `nom_complet` varchar(255) NOT NULL COMMENT 'Nom complet de l''utilisateur',
  `email` varchar(255) NOT NULL COMMENT 'Adresse e-mail de l''utilisateur',
  `mot_de_passe` varchar(255) NOT NULL COMMENT 'Mot de passe de l''utilisateur',
  `id_adresse_livraison` int(11) NOT NULL COMMENT 'ID de l''adresse de livraison',
  `id_adresse_facturation` int(11) NOT NULL COMMENT 'ID de l''adresse de facturation',
  `role` enum('client','vendeur') NOT NULL COMMENT 'Rôle de l''utilisateur (client ou vendeur)',
  `historique_achats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Historique des achats de l''utilisateur (au format JSON)' CHECK (json_valid(`historique_achats`)),
  `age` int(11) DEFAULT NULL COMMENT 'Âge de l''utilisateur',
  `sexe` enum('homme','femme','autre') DEFAULT NULL COMMENT 'Sexe de l''utilisateur',
  `date_de_naissance` date DEFAULT NULL COMMENT 'Date de naissance de l''utilisateur',
  `numero_telephone` varchar(20) DEFAULT NULL COMMENT 'Numéro de téléphone de l''utilisateur',
  `photo_profil` varchar(255) DEFAULT NULL COMMENT 'URL de la photo de profil de l''utilisateur',
  `id_methode_authentification` int(11) DEFAULT NULL COMMENT 'ID de la méthode d''authentification utilisée',
  `preferences_communication` enum('oui','non') DEFAULT NULL COMMENT 'Préférences de communication de l''utilisateur',
  `statut_compte` enum('actif','inactif','suspendu') NOT NULL COMMENT 'Statut du compte utilisateur'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_utilisateur`, `nom_complet`, `email`, `mot_de_passe`, `id_adresse_livraison`, `id_adresse_facturation`, `role`, `historique_achats`, `age`, `sexe`, `date_de_naissance`, `numero_telephone`, `photo_profil`, `id_methode_authentification`, `preferences_communication`, `statut_compte`) VALUES
(1, 'Jean Dupont', 'jean.dupont@email.com', 'motdepasse123', 1, 2, 'client', NULL, 30, 'homme', '1994-05-15', '+123456789', 'url_photo_jean.jpg', 1, 'oui', 'actif'),
(2, 'Alice Martin', 'alice.martin@email.com', 'mdpsecret456', 3, 3, 'client', NULL, 25, 'femme', '1999-08-22', '+987654321', 'url_photo_alice.jpg', 2, 'oui', 'actif'),
(3, 'Paul Lefevre', 'paul.lefevre@email.com', 'mdp12345', 2, 1, 'vendeur', NULL, 35, 'homme', '1989-03-10', '+111223344', 'url_photo_paul.jpg', 1, 'non', 'actif'),
(4, 'Sophie Moreau', 'sophie.moreau@email.com', 'secret789', 1, 2, 'client', NULL, 28, 'femme', '1993-11-05', '+1122334455', 'url_photo_sophie.jpg', 2, 'oui', 'actif'),
(5, 'Marc Dubois', 'marc.dubois@email.com', 'mdp56789', 2, 3, 'vendeur', NULL, 40, 'homme', '1982-07-18', '+9988776655', 'url_photo_marc.jpg', 1, 'non', 'actif');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adresse_facturation`
--
ALTER TABLE `adresse_facturation`
  ADD PRIMARY KEY (`id_adresse_facturation`);

--
-- Index pour la table `adresse_livraison`
--
ALTER TABLE `adresse_livraison`
  ADD PRIMARY KEY (`id_adresse_livraison`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id_categorie`);

--
-- Index pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`id_commande`),
  ADD KEY `id_utilisateur` (`id_utilisateur`),
  ADD KEY `id_adresse_livraison` (`id_adresse_livraison`),
  ADD KEY `id_adresse_facturation` (`id_adresse_facturation`);

--
-- Index pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD PRIMARY KEY (`id_commentaire`),
  ADD KEY `id_utilisateur` (`id_utilisateur`),
  ADD KEY `id_produit` (`id_produit`);

--
-- Index pour la table `factures`
--
ALTER TABLE `factures`
  ADD PRIMARY KEY (`id_facture`),
  ADD KEY `id_commande` (`id_commande`);

--
-- Index pour la table `historique_achats`
--
ALTER TABLE `historique_achats`
  ADD PRIMARY KEY (`id_achat`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `historique_commandes`
--
ALTER TABLE `historique_commandes`
  ADD PRIMARY KEY (`id_histo_commande`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `historique_navigation`
--
ALTER TABLE `historique_navigation`
  ADD PRIMARY KEY (`id_historique`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `historique_paiements`
--
ALTER TABLE `historique_paiements`
  ADD PRIMARY KEY (`id_histo_paiement`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `methodes_authentification`
--
ALTER TABLE `methodes_authentification`
  ADD PRIMARY KEY (`id_methode`);

--
-- Index pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD PRIMARY KEY (`id_paiement`),
  ADD KEY `id_facture` (`id_facture`),
  ADD KEY `id_commande` (`id_commande`);

--
-- Index pour la table `paniers`
--
ALTER TABLE `paniers`
  ADD PRIMARY KEY (`id_panier`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`id_produit`),
  ADD KEY `id_categorie` (`id_categorie`),
  ADD KEY `id_sous_categorie` (`id_sous_categorie`);

--
-- Index pour la table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id_promotion`);

--
-- Index pour la table `sous_categories`
--
ALTER TABLE `sous_categories`
  ADD PRIMARY KEY (`id_sous_categorie`),
  ADD KEY `id_categorie` (`id_categorie`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD KEY `id_adresse_livraison` (`id_adresse_livraison`),
  ADD KEY `id_adresse_facturation` (`id_adresse_facturation`),
  ADD KEY `id_methode_authentification` (`id_methode_authentification`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `adresse_facturation`
--
ALTER TABLE `adresse_facturation`
  MODIFY `id_adresse_facturation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `adresse_livraison`
--
ALTER TABLE `adresse_livraison`
  MODIFY `id_adresse_livraison` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_categorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `commandes`
--
ALTER TABLE `commandes`
  MODIFY `id_commande` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `commentaires`
--
ALTER TABLE `commentaires`
  MODIFY `id_commentaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `factures`
--
ALTER TABLE `factures`
  MODIFY `id_facture` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `historique_achats`
--
ALTER TABLE `historique_achats`
  MODIFY `id_achat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `historique_commandes`
--
ALTER TABLE `historique_commandes`
  MODIFY `id_histo_commande` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `historique_navigation`
--
ALTER TABLE `historique_navigation`
  MODIFY `id_historique` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `historique_paiements`
--
ALTER TABLE `historique_paiements`
  MODIFY `id_histo_paiement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `methodes_authentification`
--
ALTER TABLE `methodes_authentification`
  MODIFY `id_methode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `paiements`
--
ALTER TABLE `paiements`
  MODIFY `id_paiement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `paniers`
--
ALTER TABLE `paniers`
  MODIFY `id_panier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `produits`
--
ALTER TABLE `produits`
  MODIFY `id_produit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT pour la table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id_promotion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `sous_categories`
--
ALTER TABLE `sous_categories`
  MODIFY `id_sous_categorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`),
  ADD CONSTRAINT `commandes_ibfk_2` FOREIGN KEY (`id_adresse_livraison`) REFERENCES `adresse_livraison` (`id_adresse_livraison`),
  ADD CONSTRAINT `commandes_ibfk_3` FOREIGN KEY (`id_adresse_facturation`) REFERENCES `adresse_facturation` (`id_adresse_facturation`);

--
-- Contraintes pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD CONSTRAINT `commentaires_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`),
  ADD CONSTRAINT `commentaires_ibfk_2` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id_produit`);

--
-- Contraintes pour la table `factures`
--
ALTER TABLE `factures`
  ADD CONSTRAINT `factures_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commandes` (`id_commande`);

--
-- Contraintes pour la table `historique_achats`
--
ALTER TABLE `historique_achats`
  ADD CONSTRAINT `historique_achats_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);

--
-- Contraintes pour la table `historique_commandes`
--
ALTER TABLE `historique_commandes`
  ADD CONSTRAINT `historique_commandes_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);

--
-- Contraintes pour la table `historique_navigation`
--
ALTER TABLE `historique_navigation`
  ADD CONSTRAINT `historique_navigation_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);

--
-- Contraintes pour la table `historique_paiements`
--
ALTER TABLE `historique_paiements`
  ADD CONSTRAINT `historique_paiements_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);

--
-- Contraintes pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD CONSTRAINT `paiements_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commandes` (`id_commande`),
  ADD CONSTRAINT `paiements_ibfk_2` FOREIGN KEY (`id_facture`) REFERENCES `factures` (`id_facture`);

--
-- Contraintes pour la table `paniers`
--
ALTER TABLE `paniers`
  ADD CONSTRAINT `paniers_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);

--
-- Contraintes pour la table `produits`
--
ALTER TABLE `produits`
  ADD CONSTRAINT `produits_ibfk_1` FOREIGN KEY (`id_categorie`) REFERENCES `categories` (`id_categorie`),
  ADD CONSTRAINT `produits_ibfk_2` FOREIGN KEY (`id_sous_categorie`) REFERENCES `sous_categories` (`id_sous_categorie`);

--
-- Contraintes pour la table `sous_categories`
--
ALTER TABLE `sous_categories`
  ADD CONSTRAINT `sous_categories_ibfk_1` FOREIGN KEY (`id_categorie`) REFERENCES `categories` (`id_categorie`);

--
-- Contraintes pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD CONSTRAINT `utilisateurs_ibfk_1` FOREIGN KEY (`id_adresse_livraison`) REFERENCES `adresse_livraison` (`id_adresse_livraison`),
  ADD CONSTRAINT `utilisateurs_ibfk_2` FOREIGN KEY (`id_adresse_facturation`) REFERENCES `adresse_facturation` (`id_adresse_facturation`),
  ADD CONSTRAINT `utilisateurs_ibfk_3` FOREIGN KEY (`id_methode_authentification`) REFERENCES `methodes_authentification` (`id_methode`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
