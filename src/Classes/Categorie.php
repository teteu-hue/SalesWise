<?php

namespace App\Classes;

use Error;

class Categorie
{
    private string $name;

    public function getName(){
        return $this->name;
    }

    public function setName($name){
        if(strlen($name) > 100){
            throw new Error("O número de caracteres ultrapassa o estipulado pelo sistema!");
        }

        if($name == NULL){
            throw new Error("O campo não pode ser inválido!");
        }
        $this->name = $name;
    }

}
