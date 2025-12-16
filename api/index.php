<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");

require_once "config/Database.php";
require_once "controllers/ProductController.php";
require_once "controllers/UserController.php";

$method = $_SERVER['REQUEST_METHOD'];
$uri = explode('/', trim($_SERVER['REQUEST_URI'], '/'));

$resource = $uri[1] ?? null;
$id = $uri[2] ?? null;

switch ($resource) {
    case 'produits':
        $controller = new ProductController();
        if ($method === 'GET') {
            echo $id ? $controller->show($id) : $controller->index();
        }
        break;

    case 'users':
        $controller = new UserController();
        if ($method === 'POST') {
            echo $controller->store();
        }
        break;

    case 'login':
        $controller = new UserController();
        if ($method === 'POST') {
            echo $controller->login();
        }
        break;

    default:
        http_response_code(404);
        echo json_encode(["error" => "Route inexistante"]);
}
?>