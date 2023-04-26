<?php
$conn = mysqli_connect("localhost", "wordpressuser", "oM#Gb@u42!", "wordpress");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
$sql = "SELECT id, name FROM product_categories WHERE parent_id IS NULL";
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
    echo "<ul>";
    while($row = mysqli_fetch_assoc($result)) {
        echo "<li><a href=\"/index.php/products?category_id=" . $row['id'] . "\">" . $row['name'] . "</a></li>";
    }
    echo "</ul>";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
mysqli_close($conn);
?>
