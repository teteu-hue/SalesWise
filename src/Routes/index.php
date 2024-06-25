<?php

use App\Controllers\ProductController;
use App\Router;

require_once('../../vendor/autoload.php');

$router = new Router();

$router->get('/', ProductController::class, 'index');

$router->dispatch();

?>
