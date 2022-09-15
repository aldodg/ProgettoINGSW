<?php include "../inc/dbinfo.inc"; ?>


<?php
echo "1";
$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
echo "2";
if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data from the REST client
	echo "3";
	#$data="1";
	$data = json_decode(file_get_contents('php://input'), true);
	echo "4";
	echo $data;
	echo $user=$data['username'];
	echo $psw=$data['password'];
	echo $email=$data['email'];
	$sql = "INSERT INTO cinematesdb.user (username, password, email) VALUES ('$user', '$psw', '$email');";
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
