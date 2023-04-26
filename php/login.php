<?php
session_start();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  $username = $_POST['username'];
  $password = $_POST['password'];
  if (isset($username) && isset($password)) {
    $conn = mysqli_connect("localhost", "wordpressuser", "oM#Gb@u42!", "wordpress");
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }
    $sql = "SELECT username,password FROM users WHERE username=?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "s", $username);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        if (password_verify($password, $row['password'])) {
            $_SESSION['username'] = $row['username'];
            $_SESSION['loggedin'] = true;
            header('Location: /index.php/products');
            exit;
        } else {
            echo "<p style=\"color:red\">Username/password did not match!</p>";
        }
    } else {
        echo "<p style=\"color:red\">Username does not exist!</p>";
    }
    mysqli_close($conn);
  }
}
?>
