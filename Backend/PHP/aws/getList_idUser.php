<?php include "../inc/dbinfo.inc"; ?>

<?php
ini_set('display_errors', 1);
$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);


	$id = isset($_GET['id']) ? mysqli_real_escape_string($conn, $_GET['id']) :  "";
  $sql = "SELECT * FROM cinematesdb.list WHERE id='{$id}';";
	
	$get_data_query = mysqli_query($conn, $sql) or die(mysqli_error($conn));
		if(mysqli_num_rows($get_data_query)!=0){
		$result = array();

		while($r = mysqli_fetch_array($get_data_query)){
			extract($r);
			$result[] = array("id" => $id, "id_list" => $id_list, 'list_name' => $list_name, 'movies' => $movies);
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

?>
