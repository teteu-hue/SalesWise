<?php

namespace App;

use App\Models\DbProduct;

require('../vendor/autoload.php');

$db = new DbProduct();
$result = $db->getProducts();
echo "<pre>";
var_dump($result->fetchAll());
?>

