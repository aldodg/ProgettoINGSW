<?php
$conn = mysqli_connect("localhost","root","","cinematesdb");

/*questa api viene chiamata quando sto nella view delle richieste e quindi tengo già l'id_friendship preso dall'api get.
mi serve solo sapere l'azione:
 1) accettata: cambia state
 2) rifiutata: elimina riga
 3) bloccato: cambia stato -----nice to have, non richiesto e da implementare eventualmente
*/
if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data from the REST client
	$id_friendship = isset($_POST['id_friendship']) ? mysqli_real_escape_string($conn, $_POST['id_friendship']) : "";
	$action = isset($_POST['action']) ? mysqli_real_escape_string($conn, $_POST['action']) : "";
	// Insert data into database
	//RICORDA CHE PENDING DEVE ANDARE FRA VIRGOLETTE DURANTE LE QUERY DA DBEAVER
	//SU POSTMAN INVECE NON CI VANNO LE VIRGOLETTE
	if ($action == 1) {
		$sql = "UPDATE cinematesdb.friendship SET state = 'accepted' where id_friendship = '$id_friendship';";
	}
	else if ($action == 2) {
					$sql = "DELETE FROM cinematesdb.friendship where id_friendship = '$id_friendship';";
			 }
			 else {
				  $sql = "UPDATE cinematesdb.friendship SET state = 'blocked' where id_friendship = '$id_friendship';";
			 }
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
