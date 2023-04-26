<?php
session_start();

$conn = mysqli_connect("localhost", "wordpressuser", "oM#Gb@u42!", "wordpress");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

if (isset($_SESSION['shopping_cart']) && count($_SESSION['shopping_cart']) > 0) {
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        if (isset($_POST['update'])) {
            $product = intval($_POST['product_id']);
            if (array_key_exists($product, $_SESSION['shopping_cart'])) {
                $quantity = intval($_POST['quantity']);
                if ($quantity == 0) {
                    unset($_SESSION['shopping_cart'][$product]);
                } else {
                    $_SESSION['shopping_cart'][$product] = $quantity;     
                }
            }
        }
    }
    echo "<table width=\"100%\">";
    echo "<tr><th>Item</th><th>Image</th><th>Name</th><th>Price</th><th>Quantity</th></tr>";
    $count = 0;
    $total = 0;
    foreach ($_SESSION['shopping_cart'] as $product_id => $quantity) {
        $sql = "SELECT name, price, image_url FROM products WHERE id=$product_id";
        $result = mysqli_query($conn, $sql);
        if (mysqli_num_rows($result) > 0) {
            echo "<tr>";
            echo "<td style=\"text-align:center\">" . ++$count . "</td>";
            $row = mysqli_fetch_assoc($result);
            echo "<td style=\"text-align: center;\"><img src=\"" . (isset($row['image_url']) ? $row['image_url'] : "/images/unavailable.png") . "\" style=\"width:60px;height:60px;border-radius:0\" alt=\"\" /></td>";
            echo "<td>" . $row['name'] . "</td>";
            echo "<td style=\"text-align:center;\">" . $row['price'] . "</td>";
            echo "<td style=\"text-align:center\">";
            echo "<form action=\".\" method=\"POST\">";
            echo "<select name=\"quantity\">";
                for ($i = 0; $i <= 10; $i++) {
                    echo "<option value=\"$i\"" . (($i == $quantity) ? " selected=\"selected\"" : "") . ">$i</option>";
                } 
            echo "</select>";          
            echo "<input type=\"submit\" name=\"update\" value=\"Update\" />";
            echo "<input type=\"hidden\" name=\"product_id\" value=\"$product_id\" />";
            echo "</form>";
            echo "</td>";
            echo "</tr>";            
            $total += $row['price'] * $quantity;
        }
    }
    echo "</table>";
    echo "<p style=\"text-align:right;\"><span style=\"font-size:large;font-weight:bold\">Total: \$" . round($total, 2) . "</span><br /> <a href=\"/index.php/checkout\">Proceed to Checkout --></a></p>";
    mysqli_close($conn);
} else {
    echo "<p>Your shopping cart is empty.</p>";
}
?>
