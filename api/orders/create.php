<?php
header('Content-Type: application/json');
require_once '../../config/database.php';
require_once '../../controllers/OrderController.php';

session_start();

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Utilisateur non authentifié']);
    exit;
}

$userId = $_SESSION['user_id'];

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || empty($data['items'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Panier vide']);
    exit;
}

try {
    $controller = new OrderController($pdo);
    
    $_SESSION['cart'] = [];
    foreach ($data['items'] as $item) {
        $_SESSION['cart'][] = [
            'produit_id' => $item['id'],
            'taille_id' => $item['taille'],
            'quantity' => $item['quantity'],
            'price' => $item['prix']
        ];
    }
    
    $orderId = $controller->paiement($userId);
    
    echo json_encode([
        'success' => true,
        'order_id' => $orderId
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}