<?php

namespace App;

abstract class Controller
{
    protected function sendJson($data, $statusCode)
    {
        http_response_code($statusCode);

        header('Content-Type: application/json');

        $json = json_encode($data);

        return $json;
    }
}

?>
