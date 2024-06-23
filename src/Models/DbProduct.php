<?php

namespace App\Models;

use Database\Dao;
use Error;
use PDOException;

class DbProduct extends Dao{

    public function __construct()
    {
    }

    public function getProducts(){

        try {

        $query = "SELECT * FROM Products";

        $result = $this->runSelectQuery($query);

        return $result;

        } catch ( PDOException $e){
            echo $e->getMessage();
        }
    }

}

?>
