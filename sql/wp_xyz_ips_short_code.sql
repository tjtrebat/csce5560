-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 01, 2023 at 03:32 PM
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
(4, 'Show-Categories', '<?php\r\n$conn = mysqli_connect(\"localhost\", \"wordpressuser\", \"oM#Gb@u42!\", \"wordpress\");\r\nif (!$conn) {\r\n    die(\"Connection failed: \" . mysqli_connect_error());\r\n}\r\n$sql = \"SELECT id, name FROM product_categories WHERE parent_id IS NULL\";\r\n$result = mysqli_query($conn, $sql);\r\nif (mysqli_num_rows($result) > 0) {\r\n    echo \"<ul>\";\r\n    while($row = mysqli_fetch_assoc($result)) {\r\n        echo \"<li><a href=\\\"/index.php/products?category_id=\" . $row[\'id\'] . \"\\\">\" . $row[\'name\'] . \"</a></li>\";\r\n    }\r\n    echo \"</ul>\";\r\n} else {\r\n    echo \"Error: \" . $sql . \"<br>\" . $conn->error;\r\n}\r\nmysqli_close($conn);\r\n?>', '[xyz-ips snippet=\"Show-Categories\"]', 1),
(5, 'Show-Products', '<?php\r\n$sqlFilters = array();\r\n\r\n$page = 0;\r\n$resultsPerPage = 10;\r\n\r\nif ($_SERVER[\'REQUEST_METHOD\'] == \'POST\') {\r\n    if (isset($_POST[\'category_id\'])) {\r\n        $category_id = $_POST[\'category_id\'];\r\n    }\r\n    if (isset($_POST[\'search\'])) {\r\n        $search = $_POST[\'search\'];\r\n    }\r\n} else {\r\n    if (isset($_GET[\'category_id\'])) {\r\n        $category_id = $_GET[\'category_id\'];\r\n    }\r\n    if (isset($_GET[\'pageNum\'])) {\r\n        $page = intval($_GET[\'pageNum\']) - 1;\r\n    }\r\n    if (isset($_GET[\'results\'])) {\r\n        $resultsPerPage = intval($_GET[\'results\']);\r\n    }\r\n    if (isset($_GET[\'search\'])) {\r\n        $search = urldecode($_GET[\'search\']);\r\n    }\r\n}\r\n\r\nif (isset($category_id)) {\r\n    array_push($sqlFilters, \"category_id = $category_id\");\r\n}\r\nif (isset($search)) {\r\n        array_push($sqlFilters, \"LOWER(name) LIKE \'%\" . strtolower($search) . \"%\'\");\r\n}\r\n\r\necho \"<form action=\\\".\\\" method=\\\"POST\\\">\";\r\necho \"<input type=\\\"text\\\" name=\\\"search\\\" placeholder=\\\"Search by name, author, etc..\\\" \" . (isset($search) ? \"value=\\\"$search\\\"\" : \"\") . \"  />\";\r\nif (isset($category_id)) {\r\n    echo \"<input type=\\\"hidden\\\" name=\\\"category_id\\\" value=\\\"\" . $category_id . \"\\\" />\";\r\n}\r\necho \"<input type=\\\"submit\\\" value=\\\"Search\\\" />\";\r\necho \"</form>\";\r\n\r\n$conn = mysqli_connect(\"localhost\", \"wordpressuser\", \"oM#Gb@u42!\", \"wordpress\");\r\nif (!$conn) {\r\n    die(\"Connection failed: \" . mysqli_connect_error());\r\n}\r\n\r\n$offset = $page * $resultsPerPage;\r\n\r\n$whereCondition = \"\";\r\n\r\nif (!empty($sqlFilters)) {\r\n    $whereCondition = \" WHERE \";\r\n    $whereCondition .= implode(\" AND \", $sqlFilters);\r\n}\r\n\r\n$numProducts = 0;\r\n$sql = \"SELECT COUNT(*) as count FROM products\" . (!empty($whereCondition) ? $whereCondition : \"\");\r\n$result = mysqli_query($conn, $sql);\r\nif (mysqli_num_rows($result) > 0) {\r\n    $row = mysqli_fetch_assoc($result);\r\n    $numProducts = $row[\'count\'];\r\n}\r\n\r\nif ($offset >= $numProducts) {\r\n    $page = 0;\r\n    $resultsPerPage = 10;\r\n    $offset = $page * $resultsPerPage;\r\n}\r\n\r\n$sql = \"SELECT id, name, price, quantity_available, image_url FROM products\" . (!empty($whereCondition) ? $whereCondition : \"\");\r\n$sql .= \" LIMIT $resultsPerPage OFFSET $offset\";\r\n\r\n$result = mysqli_query($conn, $sql);\r\nif (mysqli_num_rows($result) > 0) {\r\n    echo \"<table>\";\r\n    echo \"<tr><th style=\\\"text-align: left;\\\">#</th><th>Image</th><th>Name</th><th>Price</th><th>Actions</th></tr>\";\r\n    $rowNum = 0;\r\n    while($row = mysqli_fetch_assoc($result)) {\r\n        echo \"<tr>\";\r\n        echo \"<td style=\\\"text-align: left;\\\">\" . (++$rowNum + ($page * $resultsPerPage)) . \"</td>\";\r\n        echo \"<td><img src=\\\"\" . (isset($row[\'image_url\']) ? $row[\'image_url\'] : \"/images/unavailable.png\") . \"\\\" alt=\\\"\\\" style=\\\"width:60px;height:60px;border-radius:0\\\" />\";\r\n        echo \"<td>\" . $row[\'name\'] . \"</td>\";\r\n        echo \"<td>\" . $row[\'price\'] . \"</td>\";\r\n        echo \"<td>\";\r\n        echo \"<form action=\\\".\\\" method=\\\"POST\\\">\";\r\n        echo \"<table>\";\r\n        echo \"<tr><td>\";\r\n        echo \"<select name=\\\"quantity\\\">\";\r\n        for ($i = 0; $i < 10; $i++) {\r\n            echo \"<option value=\\\"\" . ($i + 1) . \"\\\">\" . ($i + 1) . \"</option>\";\r\n        }\r\n        echo \"</select>\";\r\n        echo \"</td><td>\";\r\n        echo \"<input type=\\\"submit\\\" name=\\\"submit\\\" value=\\\"Buy\\\" />\";\r\n        echo \"</td></tr></table>\";\r\n        echo \"<input type=\\\"hidden\\\" name=\\\"product_id\\\" value=\\\"\" . $row[\'id\'] . \"\\\" />\";\r\n        echo \"</form>\";\r\n        echo \"</td>\";\r\n        echo \"</tr>\";\r\n    }\r\n    echo \"</table>\";\r\n    echo \"<label for=\\\"resultsPerPage\\\">Show Results:</label> <select id=\\\"resultsPerPage\\\" onchange=\\\"updateResults()\\\">\";\r\n    for ($i = 10; $i <= 50; $i +=10) {\r\n        echo \"<option value=\\\"$i\\\"\" . ($resultsPerPage == $i ? \" selected=\\\"selected\\\"\" : \"\") . \">$i</option>\";\r\n    } \r\n    echo \"</select>\";\r\n    $queryParams = array();\r\n    if (isset($category_id)) {\r\n        array_push($queryParams, \"category_id=$category_id\");\r\n    }\r\n    if (isset($search)) {\r\n        array_push($queryParams, \"search=\" . urlencode($search));\r\n    }\r\n    if (isset($resultsPerPage)) {\r\n        array_push($queryParams, \"results=\" . $resultsPerPage);\r\n    }\r\n    if ($page > 0) {\r\n        array_push($queryParams, \"pageNum=$page\");\r\n        echo \"<a href=\\\"/index.php/products?\" . implode(\"&\", $queryParams) . \"\\\" style=\\\"padding-left: 10px\\\">&laquo; Prev</a>\";\r\n    }\r\n    if ($offset + $resultsPerPage < $numProducts) {\r\n        array_push($queryParams, \"pageNum=\" . ($page + 2));\r\n        echo \"<a href=\\\"/index.php/products?\" . implode(\"&\", $queryParams) . \"\\\" style=\\\"padding-left: 10px\\\">Next &raquo;</a>\";\r\n    }\r\n    echo \"<script type=\\\"text/javascript\\\">\";\r\n    echo \"function updateResults() {\";\r\n        echo \"var resultsPerPage = document.getElementById(\'resultsPerPage\');\";\r\n        echo \"var url = new URL(window.location.href);\";\r\n        if (isset($category_id)) {\r\n            echo \"url.searchParams.set(\'category_id\', $category_id);\";\r\n        }\r\n        if (isset($search)) {\r\n            echo \"url.searchParams.set(\'search\', \'\" . urlencode($search) . \"\');\";\r\n        }\r\n        echo \"url.searchParams.set(\'results\', resultsPerPage.value);\";\r\n        echo \"window.location = url.href;\";\r\n    echo \"}\";\r\n    echo \"</script>\";\r\n} else {\r\n    echo \"Error: \" . $sql . \"<br>\" . $conn->error;\r\n}\r\nmysqli_close($conn);\r\n?>', '[xyz-ips snippet=\"Show-Products\"]', 1);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
