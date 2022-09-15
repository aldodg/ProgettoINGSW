<?php
class Database
	{
	// credenziali
	private $host = "aaqp81kx0a7ezz.ckta6hgliogm.us-east-2.rds.amazonaws.com";
	private $db_name = "aaqp81kx0a7ezz";
	private $username = "admin";
	private $password = "cinematesdbpsw";
	public $conn;
	// connessione al database
	public function getConnection()
		{
		$this->conn = null;
		try
			{
			$this->conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);
			$this->conn->exec("set names utf8");
			}
		catch(PDOException $exception)
			{
			echo "Errore di connessione: " . $exception->getMessage();
			}
		return $this->conn;
		}
	}
?>
