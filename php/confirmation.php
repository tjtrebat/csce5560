<?php
session_start();

$conn = mysqli_connect("localhost", "wordpressuser", "oM#Gb@u42!", "wordpress");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

echo "<div style=\"width:100%\">";
if (isset($_SESSION['confirmation_id'])) {
    $confirmation_id = intval($_SESSION['confirmation_id']);
    $sql = "SELECT  confirmation_number from checkout_confirmation WHERE id=$confirmation_id";
    $result = mysqli_query($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        echo "<div style=\"border-bottom:1px dotted black\">";
        echo "<p>Thank you for ordering from mywebsite! Please print or save a copy of this page for your records.</p>";
        echo "<p>Your confirmation number is:<br /> <span style=\"font-size:x-large\">" . $row['confirmation_number'] . "</span></p>";
        echo "</div>";
        echo "<p style=\"font-weight:bold\">Order Summary</p>";
        $sql = "SELECT p.name, p.price, p.image_url, pc.quantity FROM product_checkout pc JOIN products p ON pc.product_id=p.id WHERE pc.confirmation_id=$confirmation_id";
        $result = mysqli_query($conn, $sql);
        if (mysqli_num_rows($result) > 0) {
            $count = 0;
            echo "<table width=\"100%\">";
            echo "<tr><th>Item</th><th>Image</th><th>Name</th><th>Price</th><th>Qty.</th></tr>";
            while ($row = mysqli_fetch_assoc($result)) {
                echo "<tr>";
                echo "<td style=\"text-align:center\">" . (++$count) . "</td>";
                echo "<td style=\"text-align:center\"><img src=\"" . (isset($row['image_url']) ? $row['image_url'] : "/images/unavailable.png") . "\" alt=\"\" style=\"width:60px;height:60px;border-radius:0\" /></td>";
                echo "<td>" . $row['name'] . "</td>";
                echo "<td style=\"text-align:center\">" . $row['price'] . "</td>";
                echo "<td style=\"text-align:center\">" . $row['quantity'] . "</td>";
                echo"</tr>";
            }
            echo "</table>";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    mysqli_close($conn);
} else {
    echo "No checkout items to display.";
}
echo "</div>";
?>
