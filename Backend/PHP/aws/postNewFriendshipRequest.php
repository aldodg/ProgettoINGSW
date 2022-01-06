<?php include "../inc/dbinfo.inc"; ?>

<?php

$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data from the REST client
	$id1 = isset($_POST['id1']) ? mysqli_real_escape_string($conn, $_POST['id1']) : "";
	$id2 = isset($_POST['id2']) ? mysqli_real_escape_string($conn, $_POST['id2']) : "";
	$state = isset($_POST['state']) ? mysqli_real_escape_string($conn, $_POST['state']) : "";
	// Insert data into database
	//RICORDA CHE PENDING DEVE ANDARE FRA VIRGOLETTE DURANTE LE QUERY DA DBEAVER
	//SU POSTMAN INVECE NON CI VANNO LE VIRGOLETTE
	$sql = "INSERT INTO cinematesdb.friendship (id1, id2, state) VALUES ('$id1', '$id2', '$state');";
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
