<?php

/* You should enable error reporting for mysqli before attempting to make a connection */
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$mysqli = new mysqli("cinematesdb.ckta6hgliogm.us-east-2.rds.amazonaws.com","admin","cinematesdbpsw","cinematesdb", "3306");

/* Set the desired charset after establishing a connection */
$mysqli->set_charset('utf8mb4');

printf("Success... %s\n", $mysqli->host_info);
