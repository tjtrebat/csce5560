<?php
session_start();

$conn = mysqli_connect("localhost", "wordpressuser", "oM#Gb@u42!", "wordpress");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

if (empty($_SESSION['csrf_token'])) {
    if (function_exists('random_bytes')) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    } else {
        $_SESSION['csrf_token'] = bin2hex(openssl_random_pseudo_bytes(32));
    }
}

$csrf_token = $_SESSION['csrf_token'];

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['csrf_token']) && $_POST['csrf_token'] == $_SESSION['csrf_token']) {
        $username = $_POST['username'];
        $password = $_POST['password'];
        if (isset($username) && isset($password)) {
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
    } else {
        echo "<p style=\"color: red\">The form submission could not be processed because the security token did not match. This could be due to a potential CSRF attack on the website. Please try again, ensuring that all form fields are filled in correctly, and that you have not navigated away from the form page or submitted the form more than once. If the issue persists, please contact support for assistance.</p>";    
    }
}

echo "<form action=\".\" method=\"POST\">";
echo "Username: <input type=\"text\" name=\"username\"><br>";
echo "Password: <input type=\"password\" name=\"password\"><br>";
echo "<input type=\"hidden\" name=\"csrf_token\" value=\"$csrf_token\" />";
echo "<input type=\"submit\" value=\"Login\">";
echo "</form>";
?>
