-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2023 at 05:54 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `forklift`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `idAcc` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `job` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`idAcc`, `username`, `password`, `name`, `job`) VALUES
(1, 'admin12345', '1234', '홍길동', '강사'),
(2, '', '', '', ''),
(3, 'ksw123', '9876', '', '학생'),
(4, 'qwer1234', '1234', '김이박', '학생');

-- --------------------------------------------------------

--
-- Table structure for table `deduction`
--

CREATE TABLE `deduction` (
  `idDed` int(11) NOT NULL,
  `idRecord` int(11) NOT NULL,
  `idRule` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `point` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `deduction`
--
DELIMITER $$
CREATE TRIGGER `numOfDedInRecord_delete` AFTER DELETE ON `deduction` FOR EACH ROW BEGIN
   SET @numOfDed = (SELECT COUNT(*) FROM deduction WHERE idRecord = OLD.idRecord);
    UPDATE record 
    SET deduction = @numOfDed
    WHERE idRecord = OLD.idRecord;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `numOfDedInRecord_insert` AFTER INSERT ON `deduction` FOR EACH ROW BEGIN
    SET @numOfDed = (SELECT COUNT(*) FROM deduction WHERE idRecord = NEW.idRecord);
    UPDATE record 
    SET deduction = @numOfDed
    WHERE idRecord = NEW.idRecord;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `numOfDedInRecord_update` AFTER UPDATE ON `deduction` FOR EACH ROW BEGIN
    SET @numOfDed = (SELECT COUNT(*) FROM deduction WHERE idRecord = NEW.idRecord);
    UPDATE record
    SET deduction = @numOfDed
    WHERE idRecord = NEW.idRecord;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `disqualification`
--

CREATE TABLE `disqualification` (
  `idDis` int(11) NOT NULL,
  `idRecord` int(11) NOT NULL,
  `idRule` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `disqualification`
--
DELIMITER $$
CREATE TRIGGER `numOfDis_delete` AFTER DELETE ON `disqualification` FOR EACH ROW BEGIN
   SET @numOfDis = (SELECT COUNT(*) FROM disqualification WHERE idRecord = OLD.idRecord);
    UPDATE record 
    SET disqualification = @numOfDis
    WHERE idRecord = OLD.idRecord;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `numOfDis_insert` AFTER INSERT ON `disqualification` FOR EACH ROW BEGIN
    SET @numOfDis = (SELECT COUNT(*) FROM disqualification WHERE idRecord = NEW.idRecord);
    UPDATE record 
    SET disqualification = @numOfDis
    WHERE idRecord = NEW.idRecord;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `record`
--

CREATE TABLE `record` (
  `idRecord` int(11) NOT NULL,
  `idAcc` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `mode` varchar(20) NOT NULL,
  `deduction` int(11) NOT NULL,
  `disqualification` int(11) NOT NULL,
  `result` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rule`
--

CREATE TABLE `rule` (
  `idRule` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rule`
--

INSERT INTO `rule` (`idRule`, `name`, `description`) VALUES
(1, 'Begin', '시작'),
(2, 'Forward_1', '전진1'),
(3, 'Lift_1', '파랫트 들기'),
(4, 'Back_1', '후진1'),
(5, 'Forward_2', '다음 포인트로 전진 이동'),
(6, 'Landing_1', '파랫트 내려놓기'),
(7, 'Back_2', '주차하기'),
(8, 'Lift_2', '파랫트 들기'),
(9, 'Back_3', '후진으로 이동하기'),
(10, 'Back_4', '후진으로 이동하기'),
(11, 'Forward_3', '드럼통으로 이동'),
(12, 'Landing_2', '파랫트 내려놓기'),
(13, 'Back_5', '주차하기'),
(14, 'Update', '업데이트');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`idAcc`);

--
-- Indexes for table `deduction`
--
ALTER TABLE `deduction`
  ADD PRIMARY KEY (`idDed`),
  ADD KEY `deduction_01` (`idRule`),
  ADD KEY `deduction_02` (`idRecord`);

--
-- Indexes for table `disqualification`
--
ALTER TABLE `disqualification`
  ADD PRIMARY KEY (`idDis`),
  ADD KEY `disqualification_01` (`idRule`),
  ADD KEY `disqualification_02` (`idRecord`);

--
-- Indexes for table `record`
--
ALTER TABLE `record`
  ADD PRIMARY KEY (`idRecord`),
  ADD KEY `record_ibfk_1` (`idAcc`);

--
-- Indexes for table `rule`
--
ALTER TABLE `rule`
  ADD PRIMARY KEY (`idRule`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `deduction`
--
ALTER TABLE `deduction`
  MODIFY `idDed` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `disqualification`
--
ALTER TABLE `disqualification`
  MODIFY `idDis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `deduction`
--
ALTER TABLE `deduction`
  ADD CONSTRAINT `deduction_01` FOREIGN KEY (`idRule`) REFERENCES `rule` (`idRule`) ON DELETE CASCADE,
  ADD CONSTRAINT `deduction_02` FOREIGN KEY (`idRecord`) REFERENCES `record` (`idRecord`) ON DELETE CASCADE;

--
-- Constraints for table `disqualification`
--
ALTER TABLE `disqualification`
  ADD CONSTRAINT `disqualification_01` FOREIGN KEY (`idRule`) REFERENCES `rule` (`idRule`) ON DELETE CASCADE,
  ADD CONSTRAINT `disqualification_02` FOREIGN KEY (`idRecord`) REFERENCES `record` (`idRecord`) ON DELETE CASCADE;

--
-- Constraints for table `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`idAcc`) REFERENCES `account` (`idAcc`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
