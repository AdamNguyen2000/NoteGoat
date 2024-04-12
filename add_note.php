<?php
// Connect to database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "notes_db";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get form data
$name = $_POST['name'];
$address = $_POST['address'];
$phone = $_POST['phone'];
$email = $_POST['email'];
$note = $_POST['note'];

// Insert data into database
$sql = "INSERT INTO notes (name, address, phone, email, note) VALUES ('$name', '$address', '$phone', '$email', '$note')";

if ($conn->query($sql) === TRUE) {
    echo "Note added successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
