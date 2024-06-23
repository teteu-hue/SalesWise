<?php

namespace App;

require('../vendor/autoload.php');

use Database\Dao;

$db = new Dao();

$result = $db->testConnection();

var_dump($result);

?>

