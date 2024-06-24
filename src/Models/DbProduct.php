<?php

namespace App\Models;

use App\Classes\Product;
use Database\Dao;
use Error;
use Exception;
use PDOException;

class DbProduct extends Dao
{

    public function __construct()
    {
    }

    public function getProductById($id){
        try{
            $sql = "SELECT * FROM Products WHERE id_product = $id";

            $result = $this->runSelectQuery($sql);
            return $result;

        } catch(PDOException $e){
            echo $e->getMessage();
        }
    }

    public function getProducts()
    {
        try {
            $query = "SELECT * FROM Products";
            $result = $this->runSelectQuery($query);
            return $result;
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    public function createProduct(Product $product, $id_categorie)
    {
        try {

            $this->getConnection();

            $query = "CALL insert_product(:name, :price, :categorie)";

            $stmt = $this->connection->prepare($query);

            $data = [
                ":name" => $product->getName(),
                ":price" => $product->getPrice(),
                ":categorie" => $id_categorie
            ];

            $result = $stmt->execute($data);
            $this->connection = null;
            return $result;

        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
}
