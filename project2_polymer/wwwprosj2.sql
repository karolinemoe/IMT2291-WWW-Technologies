-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 02. Mar, 2018 15:13 PM
-- Server-versjon: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wwwprosj1`
--

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `abonnent`
--

CREATE TABLE `abonnent` (
  `brukerId` int(11) NOT NULL,
  `spillelisteId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `bruker`
--

CREATE TABLE `bruker` (
  `id` int(11) NOT NULL,
  `brukernavn` varchar(50) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `passord` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `vilBliLaerer` tinyint(1) NOT NULL,
  `laerer` tinyint(1) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `navn` varchar(100) CHARACTER SET utf8 COLLATE utf8_danish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dataark for tabell `bruker`
--

INSERT INTO `bruker` (`id`, `brukernavn`, `passord`, `vilBliLaerer`, `laerer`, `admin`, `navn`) VALUES
(10, 'testStudent@mail', '$2y$10$iFaQZmlghImYcNcNXHaBOe10tYfTZ3tkuGVG0/if6cncmiJGUtcm.', 0, 0, 0, NULL),
(11, 'testLaerer@mail', '$2y$10$J4ZMNS5qnPcBxjg.ivKKN.Fm2ii25D5FzW7LcnFNRPGwsxeCG2u2i', 0, 1, 0, 'Nerd'),
(12, 'testAdmin@mail', '$2y$10$F.AAy4LOF7i8ULhqriD1dO9C0nqt/e7IdE/dxkfwYuC92rVBw.dCG', 0, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `kommentar`
--

CREATE TABLE `kommentar` (
  `id` int(11) NOT NULL,
  `brukerId` int(11) NOT NULL,
  `dato` date NOT NULL,
  `innhold` varchar(2000) NOT NULL,
  `videoId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `spilleliste`
--

CREATE TABLE `spilleliste` (
  `id` int(11) NOT NULL,
  `foreleser` varchar(100) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `navn` varchar(100) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `beskrivelse` varchar(250) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `emne` varchar(100) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `stemme`
--

CREATE TABLE `stemme` (
  `brukerId` int(11) NOT NULL,
  `videoId` int(11) NOT NULL,
  `stem` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `video`
--

CREATE TABLE `video` (
  `id` int(11) NOT NULL,
  `opplasterId` int(11) NOT NULL,
  `dato` date NOT NULL,
  `beskrivelse` varchar(250) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `tittel` varchar(50) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `foreleser` varchar(50) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `emne` varchar(100) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL,
  `spillelisteId` int(11) DEFAULT NULL,
  `rekkefolge` int(11) DEFAULT NULL,
  `bildeLink` varchar(100) NOT NULL,
  `mediaLink` varchar(100) NOT NULL,
  `rangering` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `abonnent`
--
ALTER TABLE `abonnent`
  ADD PRIMARY KEY (`brukerId`,`spillelisteId`),
  ADD KEY `spillelisteId` (`spillelisteId`);

--
-- Indexes for table `bruker`
--
ALTER TABLE `bruker`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brukernavn` (`brukernavn`);

--
-- Indexes for table `kommentar`
--
ALTER TABLE `kommentar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brukerId` (`brukerId`),
  ADD KEY `videoId` (`videoId`);

--
-- Indexes for table `spilleliste`
--
ALTER TABLE `spilleliste`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stemme`
--
ALTER TABLE `stemme`
  ADD PRIMARY KEY (`brukerId`,`videoId`),
  ADD KEY `videoId` (`videoId`);

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`id`),
  ADD KEY `opplasterId` (`opplasterId`),
  ADD KEY `spillelisteId` (`spillelisteId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bruker`
--
ALTER TABLE `bruker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `kommentar`
--
ALTER TABLE `kommentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `spilleliste`
--
ALTER TABLE `spilleliste`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Begrensninger for dumpede tabeller
--

--
-- Begrensninger for tabell `abonnent`
--
ALTER TABLE `abonnent`
  ADD CONSTRAINT `abonnent_ibfk_1` FOREIGN KEY (`brukerId`) REFERENCES `bruker` (`id`),
  ADD CONSTRAINT `abonnent_ibfk_2` FOREIGN KEY (`spillelisteId`) REFERENCES `spilleliste` (`id`);

--
-- Begrensninger for tabell `kommentar`
--
ALTER TABLE `kommentar`
  ADD CONSTRAINT `kommentar_ibfk_1` FOREIGN KEY (`brukerId`) REFERENCES `bruker` (`id`),
  ADD CONSTRAINT `kommentar_ibfk_2` FOREIGN KEY (`videoId`) REFERENCES `video` (`id`);

--
-- Begrensninger for tabell `stemme`
--
ALTER TABLE `stemme`
  ADD CONSTRAINT `stemme_ibfk_1` FOREIGN KEY (`brukerId`) REFERENCES `bruker` (`id`),
  ADD CONSTRAINT `stemme_ibfk_2` FOREIGN KEY (`videoId`) REFERENCES `video` (`id`);

--
-- Begrensninger for tabell `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `video_ibfk_1` FOREIGN KEY (`opplasterId`) REFERENCES `bruker` (`id`),
  ADD CONSTRAINT `video_ibfk_2` FOREIGN KEY (`spillelisteId`) REFERENCES `spilleliste` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
