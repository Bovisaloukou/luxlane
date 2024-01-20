-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 12 août 2023 à 01:58
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecommercedb`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresses`
--

CREATE TABLE `adresse_facturation` (
  `id_adresse_facturation` int(11) NOT NULL,
  `rue` varchar(255) DEFAULT NULL COMMENT 'Rue de l''adresse',
  `ville` varchar(255) DEFAULT NULL COMMENT 'Ville de l''adresse',
  `code_postal` varchar(20) DEFAULT NULL COMMENT 'Code postal de l''adresse',
  `pays` varchar(255) DEFAULT NULL COMMENT 'Pays de l''adresse'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `adresse_livraison` (
  `id_adresse_livraison` int(11) NOT NULL,
  `rue` varchar(255) DEFAULT NULL COMMENT 'Rue de l''adresse',
  `ville` varchar(255) DEFAULT NULL COMMENT 'Ville de l''adresse',
  `code_postal` varchar(20) DEFAULT NULL COMMENT 'Code postal de l''adresse',
  `pays` varchar(255) DEFAULT NULL COMMENT 'Pays de l''adresse'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

CREATE TABLE `factures` (
  `id_facture` int(11) NOT NULL,
  `id_commande` int(11) DEFAULT NULL COMMENT 'ID de la commande associée',
  `montant_total` decimal(10,2) NOT NULL COMMENT 'Montant total de la facture',
  `date_facture` date NOT NULL COMMENT 'Date de la facture'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `historique_achats`
--

CREATE TABLE `historique_achats` (
  `id_achat` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `achats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Détails des achats (au format JSON)' CHECK (json_valid(`achats`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `historique_commandes`
--

CREATE TABLE `historique_commandes` (
  `id_histo_commande` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `commandes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Détails des commandes (au format JSON)' CHECK (json_valid(`commandes`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `historique_navigation`
--

CREATE TABLE `historique_navigation` (
  `id_historique` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `page_visitee` varchar(255) NOT NULL COMMENT 'Page visitée par l''utilisateur',
  `date_visite` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date de la visite'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `historique_paiements`
--

CREATE TABLE `historique_paiements` (
  `id_histo_paiement` int(11) NOT NULL,
  `id_utilisateur` int(11) DEFAULT NULL COMMENT 'ID de l''utilisateur associé',
  `paiements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Détails des paiements (au format JSON)' CHECK (json_valid(`paiements`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `methodes_authentification`
--

CREATE TABLE `methodes_authentification` (
  `id_methode` int(11) NOT NULL,
  `nom_methode` varchar(50) NOT NULL COMMENT 'Nom de la méthode d''authentification'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adresses`
--
ALTER TABLE `adresse_facturation`
  ADD INDEX `idx_id_adresse_facturation` (`id_adresse_facturation`);

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
-- AUTO_INCREMENT pour la table `adresses`
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_categorie` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `commandes`
--
ALTER TABLE `commandes`
  MODIFY `id_commande` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `commentaires`
--
ALTER TABLE `commentaires`
  MODIFY `id_commentaire` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `factures`
--
ALTER TABLE `factures`
  MODIFY `id_facture` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historique_achats`
--
ALTER TABLE `historique_achats`
  MODIFY `id_achat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historique_commandes`
--
ALTER TABLE `historique_commandes`
  MODIFY `id_histo_commande` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historique_navigation`
--
ALTER TABLE `historique_navigation`
  MODIFY `id_historique` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historique_paiements`
--
ALTER TABLE `historique_paiements`
  MODIFY `id_histo_paiement` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `methodes_authentification`
--
ALTER TABLE `methodes_authentification`
  MODIFY `id_methode` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `paiements`
--
ALTER TABLE `paiements`
  MODIFY `id_paiement` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `paniers`
--
ALTER TABLE `paniers`
  MODIFY `id_panier` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `produits`
--
ALTER TABLE `produits`
  MODIFY `id_produit` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id_promotion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `sous_categories`
--
ALTER TABLE `sous_categories`
  MODIFY `id_sous_categorie` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT;

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
