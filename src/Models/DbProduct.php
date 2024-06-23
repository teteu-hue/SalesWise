<?php

namespace App\Models;

use App\Classes\Product;
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

    public function createProduct(Product $product){
        $this->getConnection();

        $query = "CALL insert_product(:name, :price, :categorie)";

        $stmt = $this->connection->prepare($query);

        $data = [
            ":name" => $product->getName(),
            ":price" => $product->getPrice(),
            ":categorie" => 1
        ];

        $result = $stmt->execute($data);

        $this->connection = null;

        return $result;
    }

}

?>
