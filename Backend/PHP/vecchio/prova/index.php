<?php
$dbhost = $_SERVER["aaqp81kx0a7ezz.ckta6hgliogm.us-east-2.rds.amazonaws.com"];
$dbport = $_SERVER[3306];
$dbname = $_SERVER["aaqp81kx0a7ezz"];
$charset = 'utf8' ;

$dsn = "mysql:host={$dbhost};port={$dbport};dbname={$dbname};charset={$charset}";
$username = $_SERVER["admin"];
$password = $_SERVER["cinematesdbpsw"];

$pdo = new PDO($dsn, $username, $password);
?>
