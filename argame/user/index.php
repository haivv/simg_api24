<?php
error_reporting(E_ALL & ~E_WARNING);
ini_set('display_errors', 0);
$conn = mysqli_connect("localhost", "root", "", "argame");
mysqli_set_charset($conn,"utf8");

if(!isset($_GET["username"]) and !isset($_GET["password"]) ){
    $result = mysqli_query($conn, "SELECT * FROM  account ORDER BY score Desc");
}
else{
    $username = $_GET["username"];
$password = $_GET["password"];
    $result = mysqli_query($conn, "SELECT * FROM  account  WHERE username='$username' and password='$password'");
}
// Connect to MySQL database



mysqli_set_charset($conn, 'utf8');

// Create empty array for JSON data
$json_data = array();

// Loop through result set and convert to associative array
while ($row = mysqli_fetch_assoc($result)) {
    $json_data[] = $row;
}

// Convert PHP array to JSON
$json_output = json_encode($json_data);

//echo $json_output;

// Encryption
$secretKey = "your_secret_key"; // Replace with your actual secret key
$encryptedData = openssl_encrypt($json_output, 'AES-256-CBC', $secretKey, 0, $secretKey);

// Output the encrypted JSON data
echo base64_encode($encryptedData);

// Close MySQL connection
mysqli_close($conn);

?>

