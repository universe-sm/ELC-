<?php
include 'db_config.php';

$sql = "SELECT*FROM submitted_data";
$result = $conn->query($sql);

$data = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}else{
    echo "No submissions found!";
}

echo json_encode($data);

$conn->close();