<?php
session_start();

if (isset($_SESSION['loggedin']) || isset($_SESSION['username'])) {
    unset($_SESSION['loggedin']);
    unset($_SESSION['username']);
    header('Location: /index.php/products');
    exit;
}
?>
