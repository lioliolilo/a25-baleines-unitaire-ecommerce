-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2025 at 03:36 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rich_ricasso_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `newsletter`
--

CREATE TABLE `newsletter` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('enattente','paye','echec') NOT NULL DEFAULT 'enattente',
  `stripe_payment_id` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `user_id`, `total_amount`, `status`, `stripe_payment_id`, `created_at`, `updated_at`) VALUES
(5, 1, 129.00, 'enattente', NULL, '2025-12-17 21:36:00', '2025-12-17 21:36:00');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `produit_id` int(11) NOT NULL,
  `taille_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `produit_id`, `taille_id`, `quantity`, `price`) VALUES
(4, 5, 1, 12, 1, 129.00);

-- --------------------------------------------------------

--
-- Table structure for table `produits`
--

CREATE TABLE `produits` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `prix` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `image2` varchar(255) DEFAULT NULL,
  `type` enum('cravate','chemise') NOT NULL,
  `couleur` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `produits`
--

INSERT INTO `produits` (`id`, `nom`, `description`, `prix`, `image`, `image2`, `type`, `couleur`) VALUES
(1, 'Cravate Unicorne', 'Cravate multicolore en soie avec un design unique de unicorne vaporwave.', 129.00, 'public/images/tieX.webp', 'public/images/tie1.webp', 'cravate', 'multicolore'),
(2, 'Chemise Unicorne', 'Chemise violet en coton avec des motifs unicorne.', 249.00, 'public/images/shirt1.webp', 'public/images/tie2.webp', 'chemise', 'violet'),
(3, 'Cravate Pastel', 'Cravate rose en soie pastel à rayures.', 89.99, 'public/images/tie3.webp', 'public/images/tie4.webp', 'cravate', 'rose'),
(4, 'T-Shirt Horizon Unicorne', 'Chemise multicolore à motifs unicorne avec un effet de coucher du soleil.', 279.00, 'public/images/tshirt3.webp', 'public/images/tshirt4.webp', 'chemise', 'multicolore'),
(5, 'Cravate Lignes Colorées', 'Cravate rose en soie avec des motifs de unicornes.', 119.99, 'public/images/tie7.webp', 'public/images/tie8.webp', 'cravate', 'rose'),
(6, 'T-Shirt Unicorne Horizons', 'Chemise rose à effet horizon avec un unicorne.', 299.00, 'public/images/tshirt1.webp', 'public/images/tshirt2.webp', 'chemise', 'rose'),
(7, 'Cravate Unicorne Prismatique', 'Cravate bleu en soie avec un motif futuriste.', 135.00, 'public/images/tie5.webp', 'public/images/tie6.webp', 'cravate', 'bleu'),
(8, 'Chemise Horizons Vaporwave', 'Chemise bleu à effet horizon inspirée du vaporwave.', 220.00, 'public/images/tshirt5.webp', 'public/images/tshirt6.webp', 'chemise', 'bleu');

-- --------------------------------------------------------

--
-- Table structure for table `produit_taille`
--

CREATE TABLE `produit_taille` (
  `produit_id` int(11) NOT NULL,
  `taille_id` int(11) NOT NULL,
  `quantite` int(11) NOT NULL DEFAULT 0
) ;

--
-- Dumping data for table `produit_taille`
--

INSERT INTO `produit_taille` (`produit_id`, `taille_id`, `quantite`) VALUES
(2, 1, 5),
(2, 2, 6),
(2, 3, 4),
(2, 4, 3),
(2, 5, 2),
(2, 6, 1),
(2, 7, 0),
(4, 1, 5),
(4, 2, 6),
(4, 3, 4),
(4, 4, 3),
(4, 5, 2),
(4, 6, 1),
(4, 7, 0),
(6, 1, 5),
(6, 2, 6),
(6, 3, 4),
(6, 4, 3),
(6, 5, 2),
(6, 6, 1),
(6, 7, 0),
(8, 1, 5),
(8, 2, 6),
(8, 3, 4),
(8, 4, 3),
(8, 5, 2),
(8, 6, 1),
(8, 7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tailles`
--

CREATE TABLE `tailles` (
  `id` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `label` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tailles`
--

INSERT INTO `tailles` (`id`, `code`, `label`) VALUES
(1, '44', 'IT 44'),
(2, '46', 'IT 46'),
(3, '48', 'IT 48'),
(4, '50', 'IT 50'),
(5, '52', 'IT 52'),
(6, '54', 'IT 54'),
(7, '56', 'IT 56'),
(8, 'S', 'Small'),
(9, 'M', 'Medium'),
(10, 'L', 'Large'),
(11, 'XL', 'Extra Large'),
(12, 'Unique', 'Unique Size');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `age`, `password`) VALUES
(1, 'user@example.com', 'admin', 25, 'password123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `newsletter`
--
ALTER TABLE `newsletter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `produit_id` (`produit_id`),
  ADD KEY `taille_id` (`taille_id`);

--
-- Indexes for table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produit_taille`
--
ALTER TABLE `produit_taille`
  ADD PRIMARY KEY (`produit_id`,`taille_id`),
  ADD KEY `taille_id` (`taille_id`);

--
-- Indexes for table `tailles`
--
ALTER TABLE `tailles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `newsletter`
--
ALTER TABLE `newsletter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `produits`
--
ALTER TABLE `produits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tailles`
--
ALTER TABLE `tailles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`produit_id`) REFERENCES `produits` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_3` FOREIGN KEY (`taille_id`) REFERENCES `tailles` (`id`) ON DELETE SET NULL;

ALTER TABLE `produit_taille`
  ADD CONSTRAINT `produit_taille_ibfk_1` FOREIGN KEY (`produit_id`) REFERENCES `produits` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `produit_taille_ibfk_2` FOREIGN KEY (`taille_id`) REFERENCES `tailles` (`id`);
COMMIT;