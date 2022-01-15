<?php include "../inc/dbinfo.inc"; ?>

<?php

$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data from the REST client
	$username = isset($_POST['username']) ? mysqli_real_escape_string($conn, $_POST['username']) : "";
	$password = isset($_POST['password']) ? mysqli_real_escape_string($conn, $_POST['password']) : "";
	$email = isset($_POST['email']) ? mysqli_real_escape_string($conn, $_POST['email']) : "";
	// Insert data into database
	$sql = "INSERT INTO cinematesdb.user (username, password, email) VALUES ('$username','$password','$email' );";
	$post_data_query = mysqli_query($conn, $sql);
	if($post_data_query){
		$json = array("status" => 1, "Success" => "has been added successfully!");
	}
	else{
		$json = array("status" => 0, "Error" => "Error adding! Please try again!");
	}
}
else{
	$json = array("status" => 0, "Info" => "Request method not accepted!");
}
@mysqli_close($conn);
// Set Content-type to JSON
header('Content-type: application/json');
echo json_encode($json);
