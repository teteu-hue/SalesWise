<?php

namespace App;

use Exception;
use Throwable;

class Router
{
    /**
     * @ var array $routes
     * 
     */
    protected $routes = [];

    /**
     * @param string $route
     * @param string $controller
     * @param string $action
     * @param string $method
     * 
     * Add a route in array, with controller and action.
     * @return void
     */
    private function addRoute($route, $controller, $action, $method): void
    {
        $this->routes[$method][$route] = [
            'controller' => $controller,
            'action' => $action
        ];
    }

    /**
     * @param string $route
     * @param string $controller
     * @param string $action
     * 
     * @GET
     * @return void
     */
    public function get($route, $controller, $action): void
    {
        $this->addRoute($route, $controller, $action, "GET");
    }

    /**
     * @param string $route
     * @param string $controller
     * @param string $action
     * 
     * @POST
     * @return void
     */
    public function post($route, $controller, $action): void
    {
        $this->addRoute($route, $controller, $action, "POST");
    }

    /**
     * @param string $route
     * @param string $controller
     * @param string $action
     * 
     * @PUT
     * @return void
     */
    public function put($route, $controller, $action): void
    {
        $this->addRoute($route, $controller, $action, "POST");
    }

    /**
     * @param string $route
     * @param string $controller
     * @param string $action
     * 
     * @DELETE
     * @return void
     */
    public function delete($route, $controller, $action): void
    {
        $this->addRoute($route, $controller, $action, "POST");
    }

    /**
     * Dispatch route action
     * 
     * @return void
     */
    public function dispatch(): void
    {
        // uri that will be sent
        $url = strtok($_SERVER['REQUEST_URI'], '?');
        // method of uri. Ex: POST, PUT, GET AND DELETE
        $method = $_SERVER['REQUEST_METHOD'];

        try {
            // verify in array if de `url` exists
            if (!array_key_exists($url, $this->routes[$method])) {
                // not found `url`
                throw new Exception("No route found for URI: $url", 404);
            }
            $controller = $this->routes[$method][$url]['controller'];
            $action = $this->routes[$method][$url]['action'];

            // create a new controller
            $controller = new $controller();
            // execute a action or function
            $controller->$action();
        } catch (Throwable $th) {
            echo $th->getMessage();
        }
    }
}
