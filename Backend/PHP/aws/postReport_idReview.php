<?php include "../inc/dbinfo.inc"; ?>

<?php

$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data from the REST client
	$id_review = isset($_POST['id_review']) ? mysqli_real_escape_string($conn, $_POST['id_review']) : "";
	// Insert data into database
	$sql = "INSERT INTO cinematesdb.report (`id_review`) VALUES ('$id_review');";
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
