<?php
session_start();

$sqlFilters = array();

$page = 0;
$resultsPerPage = 10;

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['category_id']) && is_numeric($_POST['category_id'])) {
        $category_id = intval($_POST['category_id']);
    }
    if (isset($_POST['search']) && strlen(trim($_POST['search'])) > 0) {
        $search = trim($_POST['search']);
    }
    if (isset($_POST['submit'])) {
        $product = intval($_POST['product_id']);
        $quantity = intval($_POST['quantity']);
        if (!isset($_SESSION['shopping_cart'])) {
            $_SESSION['shopping_cart'] = array();
        }
        if (isset($_SESSION['shopping_cart'][$product])) {
            $_SESSION['shopping_cart'][$product] += $quantity;
        } else {
            $_SESSION['shopping_cart'][$product] = $quantity;
        }
        $urlParams = array();
        if (isset($category_id)) {
            array_push($urlParams, "category_id=$category_id");
        }
        if (isset($search)) {
            array_push($urlParams, "search=" . urlencode($search));
        }
        header("Location: /index.php/products" . ((count($urlParams) > 0) ? "?" : "") . implode("&", $urlParams));
        exit;
    }
} else {
    if (isset($_GET['category_id']) && is_numeric($_GET['category_id'])) {
        $category_id = intval($_GET['category_id']);
    }
    if (isset($_GET['pageNum']) && is_numeric($_GET['pageNum'])) {
        $page = intval($_GET['pageNum']) - 1;
    }
    if (isset($_GET['results']) && is_numeric($_GET['results'])) {
        $resultsPerPage = intval($_GET['results']);
    }
    if (isset($_GET['search']) && strlen(trim($_GET['search'])) > 0) {
        $search = urldecode(trim($_GET['search']));
    }
}

if (isset($category_id)) {
    array_push($sqlFilters, "category_id=$category_id");
}
if (isset($search) && strlen($search) > 0) {
        array_push($sqlFilters, "LOWER(name) LIKE '%" . strtolower($search) . "%'");
}

echo "<form action=\".\" method=\"POST\">";
echo "<input type=\"text\" name=\"search\" placeholder=\"Search by name, author, etc..\" " . (isset($search) ? "value=\"$search\"" : "") . "  />";
if (isset($category_id)) {
    echo "<input type=\"hidden\" name=\"category_id\" value=\"" . $category_id . "\" />";
}
echo "<input type=\"submit\" value=\"Search\" />";
echo "</form>";

$conn = mysqli_connect("localhost", "wordpressuser", "oM#Gb@u42!", "wordpress");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$offset = $page * $resultsPerPage;

$whereCondition = "";

if (!empty($sqlFilters)) {
    $whereCondition = " WHERE ";
    $whereCondition .= implode(" AND ", $sqlFilters);
}

$numProducts = 0;
$sql = "SELECT COUNT(*) as count FROM products" . (!empty($whereCondition) ? $whereCondition : "");
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $numProducts = $row['count'];
}

if ($offset >= $numProducts) {
    $page = 0;
    $resultsPerPage = 10;
    $offset = $page * $resultsPerPage;
}

$sql = "SELECT id, name, price, quantity_available, image_url FROM products" . (!empty($whereCondition) ? $whereCondition : "");
$sql .= " LIMIT $resultsPerPage OFFSET $offset";

$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
    echo "<table width=\"100%\">";
    echo "<tr><th>Item</th><th>Image</th><th>Name</th><th>Price</th><th>Actions</th></tr>";
    $rowNum = 0;
    while($row = mysqli_fetch_assoc($result)) {
        echo "<tr>";
        echo "<td style=\"text-align: center;\">" . (++$rowNum + ($page * $resultsPerPage)) . "</td>";
        echo "<td style=\"text-align: center;\"><img src=\"" . (isset($row['image_url']) ? $row['image_url'] : "/images/unavailable.png") . "\" alt=\"\" style=\"width:60px;height:60px;border-radius:0\" />";
        echo "<td>" . $row['name'] . "</td>";
        echo "<td style=\"text-align: center;\">" . $row['price'] . "</td>";
        echo "<td style=\"text-align: center;\">";
        echo "<form action=\".\" method=\"POST\">";
        echo "<select name=\"quantity\">";
        for ($i = 0; $i < 10; $i++) {
            echo "<option value=\"" . ($i + 1) . "\">" . ($i + 1) . "</option>";
        }
        echo "</select>";
        echo "<input type=\"submit\" name=\"submit\" value=\"Buy\" />";
        echo "<input type=\"hidden\" name=\"product_id\" value=\"" . $row['id'] . "\" />";
        if (isset($category_id)) {
            echo "<input type=\"hidden\" name=\"category_id\" value=\"" . $category_id . "\" />";
        }
        if (isset($search) && strlen($search) > 0) {
            echo "<input type=\"hidden\" name=\"search\" value=\"" . $search . "\" />";
        }
        echo "</form>";
        echo "</td>";
        echo "</tr>";
    }
    echo "</table>";
    echo "<label for=\"resultsPerPage\">Show Results:</label> <select id=\"resultsPerPage\" onchange=\"updateResults()\">";
    for ($i = 10; $i <= 50; $i +=10) {
        echo "<option value=\"$i\"" . ($resultsPerPage == $i ? " selected=\"selected\"" : "") . ">$i</option>";
    } 
    echo "</select>";
    $queryParams = array();
    if (isset($category_id)) {
        array_push($queryParams, "category_id=$category_id");
    }
    if (isset($search)) {
        array_push($queryParams, "search=" . urlencode($search));
    }
    if (isset($resultsPerPage)) {
        array_push($queryParams, "results=" . $resultsPerPage);
    }
    if ($page > 0) {
        array_push($queryParams, "pageNum=$page");
        echo "<a href=\"/index.php/products?" . implode("&", $queryParams) . "\" style=\"padding-left: 10px\">&laquo; Prev</a>";
    }
    if ($offset + $resultsPerPage < $numProducts) {
        array_push($queryParams, "pageNum=" . ($page + 2));
        echo "<a href=\"/index.php/products?" . implode("&", $queryParams) . "\" style=\"padding-left: 10px\">Next &raquo;</a>";
    }
    echo "<script type=\"text/javascript\">";
    echo "function updateResults() {";
        echo "var resultsPerPage = document.getElementById('resultsPerPage');";
        echo "var url = new URL(window.location.href);";
        if (isset($category_id)) {
            echo "url.searchParams.set('category_id', $category_id);";
        }
        if (isset($search)) {
            echo "url.searchParams.set('search', '" . urlencode($search) . "');";
        }
        echo "url.searchParams.set('results', resultsPerPage.value);";
        echo "window.location = url.href;";
    echo "}";
    echo "</script>";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
mysqli_close($conn);
?>