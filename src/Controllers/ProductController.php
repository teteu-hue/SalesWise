<?php

namespace App\Controllers;


use App\Controller;
use App\Models\DbProduct;


class ProductController extends Controller
{
    public function index()
    {
        $db = new DbProduct();
        $result = $db->getProducts()->fetchAll();

        $this->sendJson($result, 200);
    }
}

?>
