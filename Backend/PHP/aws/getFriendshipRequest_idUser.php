<?php include "../inc/dbinfo.inc"; ?>

<?php

$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
	/* id1 e' l'id dell'utente che invia la richiesta di amicizia a quello
	che ha id2; la query devo quindi farla su id2 dandogli l'id di colui che sta
	vedendo quali richieste di amicizia gli sono arrivate*/

	$id = isset($_GET['id']) ? mysqli_real_escape_string($conn, $_GET['id']) :  "";
	$sql = "SELECT * FROM cinematesdb.friendship WHERE id2='{$id}' AND state='pending';";
	$get_data_query = mysqli_query($conn, $sql) or die(mysqli_error($conn));
		if(mysqli_num_rows($get_data_query)!=0){
		$result = array();

		while($r = mysqli_fetch_array($get_data_query)){
			extract($r);
			$result[] = array("id1" => $id1);
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
