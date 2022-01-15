<?php

$id = $_GET['id'];
$query= "https://api.themoviedb.org/3/movie/".$id."?api_key=316933cd9b895a54e2bfcb636544e2b7";
//$query = 'https://api.themoviedb.org/3/movie/297?api_key=316933cd9b895a54e2bfcb636544e2b7';
$json = file_get_contents($query);
//echo $json;
$data = json_decode($json);
//echo $data->{'original_title'};

$json2=array("status" => 1, "info" => $data->{'original_title'});
echo json_encode($json2);

?>
