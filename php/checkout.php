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

function format_uuidv4($data) {
    assert(strlen($data) == 16);
    $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
    $data[8] = chr(ord($data[8]) & 0x3f | 0x80);
    return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
}

if (isset($_SESSION['shopping_cart']) && count($_SESSION['shopping_cart']) > 0) {
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        if (isset($_POST['csrf_token']) && $_POST['csrf_token'] == $_SESSION['csrf_token']) {
            $billing_errors = array();
            $mailing_errors = array();
            if (isset($_POST['submit'])) {
                if (isset($_POST['credit_card']) && strlen(trim($_POST['credit_card'])) > 0 ) {
                    $credit_card = str_replace(" ", "", $_POST['credit_card']);
                    if (!preg_match("/^[0-9]{1,50}$/", $credit_card)) {
                        $billing_errors['credit_card'] = 'Credit card is invalid.';
                    }
                } else {
                    $billing_errors['credit_card'] = 'Credit card must not be empty.';
                }
                if (isset($_POST['cvv']) && strlen(trim($_POST['cvv'])) > 0) {
                    $cvv = trim($_POST['cvv']);
                    if (!preg_match("/^[0-9]{1,5}$/", $cvv)) {
                        $billing_errors['cvv'] = ' CVV code is invalid.';
                    }
                } else {
                    $billing_errors['cvv'] = 'CVV code must not be empty.';    
                }
                if (isset($_POST['billing_addr_1']) && strlen(trim($_POST['billing_addr_1'])) > 0) {
                    $billing_addr_1 = trim($_POST['billing_addr_1']);
                    if (strlen($billing_addr_1) > 250) {
                        $billing_errors['billing_addr_1'] = 'Street Address 1 must be no longer than 250 characters.';
                    } else if (!preg_match("/^[A-Za-z0-9\s\.]+$/", $billing_addr_1)) {
                        $billing_errors['billing_addr_1'] = 'Street Address 1 must contain only letters, numbers, spaces and periods.';
                    }
                } else {
                    $billing_errors['billing_addr_1'] = 'Street Address 1 must not be empty.';
                }
                if (isset($_POST['billing_addr_2']) && strlen(trim($_POST['billing_addr_2'])) > 0) {
                    $billing_addr_2 = trim($_POST['billing_addr_2']);
                    if (strlen($billing_addr_2) > 250) {
                        $billing_errors['billing_addr_2'] = 'Street Address 2 must be no longer than 250 characters.';
                    } else if (!preg_match("/^[A-Za-z0-9\s\.\-]+$/", $billing_addr_2)) {
                        $billing_errors['billing_addr_2'] = 'Street Address 2 must contain only letters, numbers, spaces, dashes and periods.';
                    }
                }
                if (isset($_POST['billing_city']) && strlen(trim($_POST['billing_city'])) > 0) {
                    $billing_city = trim($_POST['billing_city']);
                    if (strlen($billing_city) > 250) {
                        $billing_errors['billing_city'] = 'City must be no longer than 250 characters.';
                    } else if (!preg_match("/^[A-Za-z\s\.\-]+$/", $billing_city)) {
                       $billing_errors['billing_city'] = 'City must contain only letters, numbers, spaces, dashes and periods.';
                    }
                } else {
                    $billing_errors['billing_city'] = 'City must not be empty.';
                }
                if (isset($_POST['billing_state']) && strlen(trim($_POST['billing_state'])) > 0) {
                    $billing_state = trim($_POST['billing_state']);
                    if (!preg_match("/^[A-Z]{2}$/", $billing_state)) {
                        $billing_errors['billing_state'] = 'State must be a valid two-letter U.S. state code.';
                    }
                } else {
                    $billing_errors['billing_state'] = 'State must not be empty.';
                }
                if (isset($_POST['billing_zip']) && strlen(trim($_POST['billing_zip'])) > 0) {
                    $billing_zip = trim($_POST['billing_zip']);
                    if (!preg_match("/^[0-9]{5}$/", $billing_zip)) {
                        $billing_errors['billing_state'] = 'Zip Code must be a valid five-digit U.S. postal code.';
                    }
                } else {
                    $billing_errors['billing_zip'] = 'Zip Code must not be empty.';
                }

                if (isset($_POST['mailing_addr_1']) && strlen(trim($_POST['mailing_addr_1'])) > 0) {
                    $mailing_addr_1 = trim($_POST['mailing_addr_1']);
                    if (strlen($mailing_addr_1) > 250) {
                        $mailing_errors['mailing_addr_1'] = 'Street Address 1 must be no longer than 250 characters.';
                    } else if (!preg_match("/^[A-Za-z0-9\s\.]+$/", $mailing_addr_1)) {
                        $mailing_errors['mailing_addr_1'] = 'Street Address 1 must contain only letters, numbers, spaces and periods.';
                    }
                } else {
                    $mailing_errors['mailing_addr_1'] = 'Street Address 1 must not be empty.';
                }
                if (isset($_POST['mailing_addr_2']) && strlen(trim($_POST['mailing_addr_2'])) > 0) {
                    $mailing_addr_2 = trim($_POST['mailing_addr_2']);
                    if (strlen($mailing_addr_2) > 250) {
                        $mailing_errors['mailing_addr_2'] = 'Street Address 2 must be no longer than 250 characters.';
                    } else if (!preg_match("/^[A-Za-z0-9\s\.\-]+$/", $mailing_addr_2)) {
                        $mailing_errors['mailing_addr_2'] = 'Street Address 2 must contain only letters, numbers, spaces, dashes and periods.';
                    }
                }
                if (isset($_POST['mailing_city']) && strlen(trim($_POST['mailing_city'])) > 0) {
                    $mailing_city = trim($_POST['mailing_city']);
                    if (strlen($mailing_city) > 250) {
                        $mailing_errors['mailing_city'] = 'City must be no longer than 250 characters.';
                    } else if (!preg_match("/^[A-Za-z\s\.\-]+$/", $mailing_city)) {
                       $mailing_errors['mailing_city'] = 'City must contain only letters, numbers, spaces, dashes and periods.';
                    }
                } else {
                    $mailing_errors['mailing_city'] = 'City must not be empty.';
                }
                if (isset($_POST['mailing_state']) && strlen(trim($_POST['mailing_state'])) > 0) {
                    $mailing_state = trim($_POST['mailing_state']);
                    if (!preg_match("/^[A-Z]{2}$/", $mailing_state)) {
                        $mailing_errors['mailing_state'] = 'State must be a valid two-letter U.S. state code.';
                    }
                } else {
                    $mailing_errors['mailing_state'] = 'State must not be empty.';
                }
                if (isset($_POST['mailing_zip']) && strlen(trim($_POST['mailing_zip'])) > 0) {
                    $mailing_zip = trim($_POST['mailing_zip']);
                    if (!preg_match("/^[0-9]{5}$/", $mailing_zip)) {
                        $mailing_errors['mailing_state'] = 'Zip Code must be a valid five-digit U.S. postal code.';
                    }
                } else {
                    $mailing_errors['mailing_zip'] = 'Zip Code must not be empty.';
                }
                if (count($billing_errors) == 0 && count($mailing_errors) == 0) {
                    $sql = "INSERT INTO checkout_confirmation (confirmation_number) VALUES ('" . format_uuidv4(random_bytes(16)) . "')";
                    if (mysqli_query($conn, $sql)) {
                        $confirmation_id = mysqli_insert_id($conn);
                        $sql = "INSERT INTO checkout_addresses (confirmation_id, billing_addr_1, billing_addr_2, billing_city, billing_state, billing_zip, mailing_addr_1, mailing_addr_2, mailing_city, mailing_state, mailing_zip) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        $stmt = mysqli_prepare($conn, $sql);
                        mysqli_stmt_bind_param($stmt, "issssssssss", $confirmation_id, $billing_addr_1, $billing_addr_2, $billing_city, $billing_state, $billing_zip, $mailing_addr_1, $mailing_addr_2, $mailing_city, $mailing_state, $mailing_zip);
                        mysqli_stmt_execute($stmt);
                        if (mysqli_stmt_affected_rows($stmt) > 0) {
                            foreach ($_SESSION['shopping_cart'] as $product_id => $quantity) {                   
                                $sql = "INSERT INTO product_checkout (confirmation_id, product_id, quantity) VALUES ($confirmation_id, $product_id, $quantity)";
                                mysqli_query($conn, $sql);
                            }
                            $_SESSION['confirmation_id'] = $confirmation_id;
                            unset($_SESSION['shopping_cart']);
                            header('Location: /index.php/confirmation');
                            exit;
                        }
                    } else {
                       echo "Error: " . $sql . "<br>" . $conn->error;
                    }
                }
            }
        } else {        
            echo "<p style=\"color: red\">The form submission could not be processed because the security token did not match. This could be due to a potential CSRF attack on the website. Please try again, ensuring that all form fields are filled in correctly, and that you have not navigated away from the form page or submitted the form more than once. If the issue persists, please contact support for assistance.</p>";        
        }
    }

    echo "<form action=\".\" method=\"POST\">";
    echo "<div style=\"width:100%;border-bottom:1px dotted black;padding-bottom:25px\">";
    if (count($billing_errors) > 0) {
        echo "<ul style=\"color:red\">";
        foreach ($billing_errors as $field => $message) {
            echo "<li>$message</li>";
        }
        echo "</ul>";
    }
    echo "<p style=\"font-weight:bold;font-size:large\">Billing Info</p>";
    echo "Credit Card No.: <input type=\"text\" name=\"credit_card\" value=\"" . ((isset($credit_card) && !array_key_exists('credit_card', $billing_errors)) ? $credit_card : "") . "\" style=\"margin:10px 5px\" />";
    echo "CVV: <input type=\"password\" name=\"cvv\" style=\"width:50px;margin:10px 5px\" /><br />";
    echo "Street Address 1: <input type=\"text\" name=\"billing_addr_1\" value=\"" . ((isset($billing_addr_1) && !array_key_exists('billing_addr_1', $billing_errors)) ? $billing_addr_1 : "") . "\" style=\"margin:10px 5px\" /><br />";
    echo "Street Address 2: <input type=\"text\" name=\"billing_addr_2\" value=\"" . ((isset($billing_addr_2) && !array_key_exists('billing_addr_2', $billing_errors)) ? $billing_addr_2 : "") . "\" style=\"margin:10px 5px\" /><br />";
    echo "City: <input type=\"text\" name=\"billing_city\" value=\"" . ((isset($billing_city) && !array_key_exists('billing_city', $billing_errors)) ? $billing_city : "") . "\" style=\"margin:10px 5px\" />";
    echo "State: <select name=\"billing_state\" style=\"margin:10px 5px\">";
    $states = array('AL'=>'Alabama', 'AK'=>'Alaska', 'AZ'=>'Arizona', 'AR'=>'Arkansas', 'CA'=>'California', 'CO'=>'Colorado', 'CT'=>'Connecticut', 'DE'=>'Delaware', 'DC'=>'District of Columbia', 'FL'=>'Florida', 'GA'=>'Georgia', 'HI'=>'Hawaii', 'ID'=>'Idaho', 'IL'=>'Illinois', 'IN'=>'Indiana', 'IA'=>'Iowa', 'KS'=>'Kansas', 'KY'=>'Kentucky', 'LA'=>'Louisiana', 'ME'=>'Maine', 'MD'=>'Maryland', 'MA'=>'Massachusetts', 'MI'=>'Michigan', 'MN'=>'Minnesota', 'MS'=>'Mississippi', 'MO'=>'Missouri', 'MT'=>'Montana', 'NE'=>'Nebraska', 'NV'=>'Nevada', 'NH'=>'New Hampshire', 'NJ'=>'New Jersey', 'NM'=>'New Mexico', 'NY'=>'New York', 'NC'=>'North Carolina', 'ND'=>'North Dakota', 'OH'=>'Ohio', 'OK'=>'Oklahoma', 'OR'=>'Oregon', 'PA'=>'Pennsylvania', 'RI'=>'Rhode Island', 'SC'=>'South Carolina', 'SD'=>'South Dakota', 'TN'=>'Tennessee', 'TX'=>'Texas', 'UT'=>'Utah', 'VT'=>'Vermont', 'VA'=>'Virginia', 'WA'=>'Washington', 'WV'=>'West Virginia', 'WI'=>'Wisconsin', 'WY'=>'Wyoming');
    foreach ($states as $state_code => $state_name) {
        echo "<option value=\"$state_code\"" . ((isset($billing_state) && $billing_state == $state_code) ? " selected=\"selected\"" : "") . ">$state_name</option>";
    }
    echo "</select> ";
    echo "Zip Code: <input type=\"text\" name=\"billing_zip\" value=\"" . ((isset($billing_zip) && !array_key_exists('billing_zip', $billing_errors)) ? $billing_zip : "") . "\" style=\"width:50px;margin:10px 5px;\" />";
    echo "</div>";
    echo "<div style=\"width:100%;border-bottom:1px dotted black;padding-bottom:25px\">";
    if (count($mailing_errors) > 0) {
        echo "<ul style=\"color:red\">";
        foreach ($mailing_errors as $field => $message) {
            echo "<li>$message</li>";
        }
        echo "</ul>";
    }
    echo "<p style=\"font-weight:bold;font-size:large\">Mailing Info</p>";
    echo "Street Address 1: <input type=\"text\" name=\"mailing_addr_1\" value=\"" . ((isset($mailing_addr_1) && !array_key_exists('mailing_addr_1', $mailing_errors)) ? $mailing_addr_1 : "") . "\" style=\"margin:10px 5px\" /><br />";
    echo "Street Address 2: <input type=\"text\" name=\"mailing_addr_2\" value=\"" . ((isset($mailing_addr_2) && !array_key_exists('mailing_addr_2', $mailing_errors)) ? $mailing_addr_2 : "") . "\" style=\"margin:10px 5px\" /><br />";
    echo "City: <input type=\"text\" name=\"mailing_city\" value=\"" . ((isset($mailing_city) && !array_key_exists('mailing_city', $mailing_errors)) ? $mailing_city : "") . "\" style=\"margin:10px 5px\" />";
    echo "State: <select name=\"mailing_state\" style=\"margin:10px 5px\">";
    foreach ($states as $state_code => $state_name) {
        echo "<option value=\"$state_code\"" . ((isset($mailing_state) && $mailing_state == $state_code) ? " selected=\"selected\"" : "") . ">$state_name</option>";
    }
    echo "</select> ";
    echo "Zip Code: <input type=\"text\" name=\"mailing_zip\" value=\"" . ((isset($mailing_zip) && !array_key_exists('mailing_zip', $mailing_errors)) ? $mailing_zip : "") . "\" style=\"width:50px;margin:10px 5px;\" />";
    echo "</div>";
    echo "<div style=\"width:100%;border-bottom:1px dotted black;padding-top:15px;\">";
    echo "<table width=\"100%\">";
    echo "<tr><th>Item</th><th>Image</th><th>Name</th><th>Price</th><th>Qty.</th></tr>";
    $count = 0;
    $total = 0;
    $totalQuantity = 0;
    foreach ($_SESSION['shopping_cart'] as $product_id => $quantity) {
        $sql = "SELECT name, price, image_url FROM products WHERE id=$product_id";
        $result = mysqli_query($conn, $sql);
        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            echo "<tr>";
            echo "<td style=\"text-align:center\">" . (++$count) . "</td>";
            echo "<td style=\"text-align:center\"><img src=\"" . (isset($row['image_url']) ? $row['image_url'] : "/images/unavailable.png") . "\" alt=\"\" style=\"width:60px;height:60px;border-radius:0\" /></td>";
            echo "<td>" . $row['name'] . "</td>";
            echo "<td style=\"text-align:center\">" . $row['price'] . "</td>";
            echo "<td style=\"text-align:center\">$quantity</td>";
            echo"</tr>";
            $total += $row['price'] * $quantity;
            $totalQuantity += $quantity;
        }
    }
    echo "</table>";
    echo "<p style=\"text-align:right;\"><span style=\"font-size:large;font-weight:bold\">Total: \$" . round($total, 2) . "</span></p>";
    echo "</div>";
    echo "<input type=\"submit\" name=\"submit\" value=\"Checkout $totalQuantity Items\" style=\"float:right;padding:10px 5px;margin-top:25px;\" />";
    echo "<input type=\"hidden\" name=\"csrf_token\" value=\"$csrf_token\" />";
    echo "</form>";
    mysqli_close($conn);
} else {
    echo "<p>You do not have any shopping cart items to checkout at this time.</p>";
}
?>
