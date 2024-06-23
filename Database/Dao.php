<?php

namespace Database;

use Error;
use PDO;
use PDOException;

class Dao{

    protected $connection;
    private string $dsn;
    private $options = [];

    public function __construct()
    {
    }

    private function getFile(){
        $file = "./database.ini";

        if(empty($file)){
            throw new Error("O arquivo do banco de dados está vazio!");
        }
        $file = parse_ini_file("database.ini");
        return $file;
    }

    private function setDsn(){
        $database = $this->getFile();

        $driver = $database["driver"];
        $dbname = $database["dbname"];
        $host = $database["host"];
        $port = $database["port"];
        
        $this->dsn = "$driver:host=$host;dbname=$dbname;port=$port";
    }

    private function getDsn(){
        $this->setDsn();
        return $this->dsn;
    }

    private function setOptions(){
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
            PDO::ATTR_PERSISTENT => true,
            PDO::CASE_LOWER => true
        ];
        $this->options = $options;
    }

    private function getOptions(){
        $this->setOptions();
        return $this->options;
    }

    public function getConnection(){

        try
        {
            $database = $this->getFile();

            $username = $database["username"];
            $password = $database["password"];

            $dsn = $this->getDsn();
            $options = $this->getOptions();

        } 
        catch (PDOException $e) 
        {
            echo $e->getMessage();
        }

        if(!isset($this->connection)){
           $this->connection = new PDO($dsn, $username, $password, $options); 
        }

        return $this->connection;        

    }
}

?>
