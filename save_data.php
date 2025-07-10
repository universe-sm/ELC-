<?php
include 'db_config.php';

$name = $_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];
$phone = $_POST['phone'];
$dob = $_POST['dob'];
$gender = $_POST['gender'];
$blood_group = $_POST['blood_group'];

// Insert all the submitted fields into the database
$sql = "INSERT INTO submitted_data (name, email, password, phone, dob, gender, blood_group)
        VALUES ('$name', '$email', '$password', '$phone', '$dob', '$gender', '$blood_group')";

if($conn->query($sql) === TRUE){
    echo "success";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>


