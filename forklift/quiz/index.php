<?php
$conn = mysqli_connect("localhost", "root", "", "forklift");
mysqli_set_charset($conn,"utf8");


$result = mysqli_query($conn, "SELECT * FROM quiz  ");

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

echo $json_output;

// Close MySQL connection
mysqli_close($conn);

?>

