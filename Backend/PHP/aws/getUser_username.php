<?php include "../inc/dbinfo.inc"; ?>

<?php

$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);

	$username = isset($_GET['username']) ? mysqli_real_escape_string($conn, $_GET['username']) :  "";
	$sql = "SELECT * FROM cinematesdb.user WHERE username='{$username}';";
	$get_data_query = mysqli_query($conn, $sql) or die(mysqli_error($conn));
		if(mysqli_num_rows($get_data_query)!=0){
		$result = array();

		while($r = mysqli_fetch_array($get_data_query)){
			extract($r);
			$result[] = array("id" => $id, "username" => $username, 'password' => $password, 'email' => $email);
		}
		$json = array("status" => 1, "info" => $result);
	}
	else{
		$json = array("status" => 0, "error" => "not found!");
	}
@mysqli_close($conn);
// Set Content-type to JSON
header('Content-type: application/json');
echo json_encode($json);
