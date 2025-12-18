<?php
header('Access-Control-Allow-Origin: http://localhost:3000');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Accept');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

session_start();

require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../controllers/OrderController.php';
require_once __DIR__ . '/../models/Order.php';
require_once __DIR__ . '/../models/OrderItem.php';

try {
    if (!isset($_SESSION['user_id'])) {
        $_SESSION['user_id'] = 1;
    }
    $userId = $_SESSION['user_id'];

    $data = json_decode(file_get_contents('php://input'), true);
    $cartItems = $data['items'] ?? [];
    if (empty($cartItems)) {
        throw new Exception('Panier vide');
    }

    $_SESSION['cart'] = $cartItems;

    $pdo = Database::getInstance();
    $orderController = new OrderController($pdo);
    $orderId = $orderController->paiement($userId);

    echo json_encode([
        'success' => true,
        'order_id' => $orderId
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
