<?php

namespace App;

use App\Classes\Product;
use App\Models\DbProduct;

require('../vendor/autoload.php');

echo "<pre>";
$db = new DbProduct();

$result = $db->getProductById(1);
var_dump($result->fetchAll());
?>

