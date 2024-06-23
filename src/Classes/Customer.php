<?php

namespace App\Classes;

use Error;

class Customer{
    private string $name;
    private string $phone;
    private string $address;

    public function getName(){
        return $this->name;
    }

    public function setName($name){
        if(strlen($name) > 100){
            throw new Error("O número de caracteres passa do suportado pelo sistema!");
        }
        if($name == NULL){
            throw new Error("O valor do campo não pode ser nulo!");
        }
        $this->name = $name;
    }

    public function getPhone(){
        return $this->phone;
    }

    public function setPhone($phone){
        if(strlen($phone) > 20){
            throw new Error("O número de telefone ultrapassa o número de caracteres");
        }
        $this->phone = $phone;
    }

    public function getAddress(){
        return $this->address;
    }

    public function setAddress($address){
        $this->address = $address;
    }

}

?>
