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
        $confirmPassword = $_POST['confirm_password'];
        if (isset($username) && isset($password) && isset($confirmPassword)) {
            $username = trim($username);
            if (strlen($username) >= 3) {
                if (preg_match("/^[A-Za-z]{1}[A-Za-z0-9_]{2,50}$/", $username)) {       
                    $sql = "SELECT 1 FROM users WHERE username=?";
                    $stmt = mysqli_prepare($conn, $sql);
                    mysqli_stmt_bind_param($stmt, "s", $username);
                    mysqli_stmt_execute($stmt);
                    $result = mysqli_stmt_get_result($stmt);
                    if (mysqli_num_rows($result) > 0) {
                        echo "<p style=\"color: red\">The username you have selected already exists.</p>";
                    } else {
                        $password = trim($password);
                        $confirmPassword = trim($confirmPassword);
                        if ($password == $confirmPassword) {
                            if (strlen($password) >= 10) {
                                if (preg_match("/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{10,}$/", $password)) {    
                                    $expiration_date = strtotime("+3 month");
                                    $sql = "INSERT INTO users (username, password, expiration_date) VALUES (?, ?, ?)";
                                    $stmt = mysqli_prepare($conn, $sql);
                                    mysqli_stmt_bind_param($stmt, "sss", $username, password_hash($password, PASSWORD_DEFAULT), date("Y-m-d", $expiration_date));                       
                                    mysqli_stmt_execute($stmt);                       
                                    if (mysqli_stmt_affected_rows($stmt) > 0) {
                                        $_SESSION['loggedin'] = true;
                                        $_SESSION['username'] = $username;
                                        header('Location: /index.php/products');
                                        exit;
                                    } else {
                                        echo "Error: " . $sql . "<br>" . mysqli_error($conn);
                                    }
                                    mysqli_close($conn);
                                } else {
                                    echo "<p style=\"color: red\">Password must contain at least one uppercase letter, one lowercase letter, one digit and one special character.</p>";
                                }
                            } else {
                                echo "<p style=\"color: red\">Password must be at least 10 characters.</p>";
                            }
                        } else {
                            echo "<p style=\"color: red\">Passwords do not match!</p>";
                        }
                    }
                } else {
                    echo "<p style=\"color: red\">Username must consist of letters, underscores and numbers.</p>";
                }
            } else {
                echo "<p style=\"color: red\">Username must be at least three characters.</p>";
            }  
        }
    } else {
        echo "<p style=\"color: red\">The form submission could not be processed because the security token did not match. This could be due to a potential CSRF attack on the website. Please try again, ensuring that all form fields are filled in correctly, and that you have not navigated away from the form page or submitted the form more than once. If the issue persists, please contact support for assistance.</p>";    
    }  
}

echo "<form action=\".\" method=\"POST\">";
echo "Username: <input type=\"text\" name=\"username\"><br>";
echo "Password: <input type=\"password\" name=\"password\"><br>";
echo "Confirm Password: <input type=\"password\" name=\"confirm_password\"><br>";
echo "<input type=\"hidden\" name=\"csrf_token\" value=\"$csrf_token\" />";
echo "<input type=\"submit\" value=\"Register\">";
echo "</form>";
?>
