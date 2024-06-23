<?php

namespace App\Classes;

use Error;

class Product
{

    private string $name;
    private string $description;
    private $price;
    private $stock_quantity;

    public function getName(){
        return $this->name;
    }

    public function setName($name){
        if($name == NULL){
            throw new Error("O nome do produto não pode ser vazio");
        }
        
        if(strlen($name) > 100){
            throw new Error("O número de caracteres do produto ultrapassa 100 caracteres!");        
        };
        $this->name = $name;
    }

    public function getDescription(){
        return $this->description;
    }

    public function setDescription($description){
        $this->description = $description;
    }

    public function getPrice(){
        return $this->price;
    }

    public function setPrice($price){
        if($price < 0){
            throw new Error("O preço do produto precisa ser maior ou igual a zero");
        }
        
        $this->price = $price;
    }

    public function getStockQuantity(){
        return $this->stock_quantity;
    }

    public function setStockQuantity($stock_quantity){
        $this->stock_quantity = $stock_quantity;
    }

}

?>
