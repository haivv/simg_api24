<?php
error_reporting(E_ALL & ~E_WARNING);
ini_set('display_errors', 0);

$conn = mysqli_connect("localhost", "root", "", "argame");
mysqli_set_charset($conn,"utf8");

$result = mysqli_query($conn, "SELECT * FROM account ORDER BY score DESC");

// Create an empty array for JSON data
$json_data = array();

// Initialize variables for ranking

$prevRank = 1; // Initialize previous rank
$prevScore = null;
$plus =null;
$stt = 1;
// Loop through the result set, convert to an associative array, and add ranking
while ($row = mysqli_fetch_assoc($result)) {
    // Create a new associative array for each row
    // Check if the current student's score is different from the previous student's score
    if ($row['score'] == $prevScore) {
        // If they have the same score, update the rank to the previous rank
         $rank = $prevRank;
    } else {
        // If they have different scores, increment the rank by 1
        $rank=$stt;
    }
    $student = array(
        'rank' => $rank,
        'idAcc' => $row['idAcc'],
        'username' => $row['username'],
        'password' => $row['password'],
        'name' => $row['name'],
        'score' => $row['score']
    );

    // Add the student data to the JSON array
    $json_data[] = $student;

    // Update the previous rank and previous score
    $prevRank = $rank;
    $prevScore = $row['score'];
    $stt++;
}

// Convert the PHP array to JSON
//$json_output = json_encode($json_data);

// Output the JSON data
//echo $json_output;

// Convert the PHP array to JSON
$json_output = json_encode($json_data);

// Encryption

// Output the encrypted JSON data
echo ($json_output);
?>

