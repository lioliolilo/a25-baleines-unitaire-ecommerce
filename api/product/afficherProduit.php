<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:3000');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type, Accept');

require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../controllers/ProductController.php';

try {
    $controller = new ProductController();
    $produits = $controller->showAll();

    echo json_encode([
        'success' => true,
        'produits' => $produits
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
