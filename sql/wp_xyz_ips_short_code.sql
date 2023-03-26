-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 25, 2023 at 08:34 PM
-- Server version: 8.0.32-0ubuntu0.20.04.2
-- PHP Version: 7.4.3-4ubuntu2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wordpress`
--

-- --------------------------------------------------------

--
-- Table structure for table `wp_xyz_ips_short_code`
--

CREATE TABLE `wp_xyz_ips_short_code` (
  `id` int NOT NULL,
  `title` varchar(1000) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `short_code` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_xyz_ips_short_code`
--

INSERT INTO `wp_xyz_ips_short_code` (`id`, `title`, `content`, `short_code`, `status`) VALUES
(1, 'date', '<?php\r\necho date(\"l jS \\of F Y h:i:s A\");\r\n?>', '[xyz-ips snippet=\"date\"]', 1),
(2, 'Insert-User', '<?php\r\nif ($_SERVER[\'REQUEST_METHOD\'] == \'POST\') {\r\n  $username = $_POST[\'username\'];\r\n  $password = $_POST[\'password\'];\r\n  if (isset($username) && isset($password)) {\r\n    $conn = mysqli_connect(\"localhost\", \"wordpressuser\", \"oM#Gb@u42!\", \"wordpress\");\r\n    if (!$conn) {\r\n        die(\"Connection failed: \" . mysqli_connect_error());\r\n    }\r\n    $sql = \"SELECT * FROM wp_users WHERE user_login=\'\" . $username . \"\'\";\r\n    $result = mysqli_query($conn, $sql);\r\n    if (mysqli_num_rows($result) > 0) {\r\n          echo \"Hello, $username! Welcome to the site\";\r\n    } else {\r\n      echo \"Error: \" . $sql . \"<br>\" . $conn->error;\r\n    }\r\n    mysqli_close($conn);\r\n  }\r\n}\r\n?>', '[xyz-ips snippet=\"Insert-User\"]', 1),
(3, 'Connect-DB', '<?php\r\n$servername = \"localhost\";\r\n$username = \"wordpressuser\";\r\n$password = \"oM#Gb@u42!\";\r\n\r\n// Create connection\r\n$conn = mysqli_connect($servername, $username, $password);\r\n\r\n// Check connection\r\nif (!$conn) {\r\n  die(\"Connection failed: \" . mysqli_connect_error());\r\n}\r\necho \"Connected successfully\";\r\n?>', '[xyz-ips snippet=\"Connect-DB\"]', 1),
(4, 'Show-Categories', '<?php\r\n$conn = mysqli_connect(\"localhost\", \"wordpressuser\", \"oM#Gb@u42!\", \"wordpress\");\r\nif (!$conn) {\r\n    die(\"Connection failed: \" . mysqli_connect_error());\r\n}\r\n$sql = \"SELECT id, name FROM product_categories WHERE parent_id IS NULL\";\r\n$result = mysqli_query($conn, $sql);\r\nif (mysqli_num_rows($result) > 0) {\r\n    echo \"<ul>\";\r\n    while($row = mysqli_fetch_assoc($result)) {\r\n        echo \"<li><a href=\\\"/index.php/products?category_id=\" . $row[\'id\'] . \"\\\">\" . $row[\'name\'] . \"</a></li>\";\r\n    }\r\n    echo \"</ul>\";\r\n} else {\r\n    echo \"Error: \" . $sql . \"<br>\" . $conn->error;\r\n}\r\nmysqli_close($conn);\r\n?>', '[xyz-ips snippet=\"Show-Categories\"]', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `wp_xyz_ips_short_code`
--
ALTER TABLE `wp_xyz_ips_short_code`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `wp_xyz_ips_short_code`
--
ALTER TABLE `wp_xyz_ips_short_code`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
