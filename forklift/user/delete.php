<?php
error_reporting(E_ALL & ~E_WARNING);
ini_set('display_errors', 0);
$conn = mysqli_connect("localhost", "root", "", "forklift");
mysqli_set_charset($conn,"utf8");

if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

$id=$_GET['id'];

// sql to delete a record
$sql = "DELETE FROM account WHERE idAcc='$id'";

if (mysqli_query($conn, $sql)) {
echo "deleted";
} else {
  echo "Error deleting record: " . mysqli_error($conn);
}
echo "test";

// Close MySQL connection
mysqli_close($conn);

?>

