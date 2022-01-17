<?php include "../inc/dbinfo.inc"; ?>

<?php

$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data from the REST client
	$data = json_decode(file_get_contents('php://input'), true);
	echo $id = $data['id'];
	echo $title = $data['title'];
	echo $body = $data['body'];
	echo $rating = $data['rating'];
	echo $id_movie = $data['id_movie'];
	// Insert data into database
	$sql = "INSERT INTO cinematesdb.review (id, title, body, rating, id_movie) VALUES ('$id', '$title', '$body', '$rating', '$id_movie');";
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
