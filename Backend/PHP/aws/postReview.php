<?php include "../inc/dbinfo.inc"; ?>

<?php

$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data from the REST client
	$id = isset($_POST['id']) ? mysqli_real_escape_string($conn, $_POST['id']) : "";
	$title = isset($_POST['title']) ? mysqli_real_escape_string($conn, $_POST['title']) : "";
	$body = isset($_POST['body']) ? mysqli_real_escape_string($conn, $_POST['body']) : "";
	$rating = isset($_POST['rating']) ? mysqli_real_escape_string($conn, $_POST['rating']) : "";
	$id_movie = isset($_POST['id_movie']) ? mysqli_real_escape_string($conn, $_POST['id_movie']) : "";
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
