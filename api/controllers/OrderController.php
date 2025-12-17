<?php
session_start();
require_once 'models/Order.php';
require_once 'models/OrderItem.php';

class OrderController {
    private $db;
    private $orderModel;
    private $orderItemModel;

    public function __construct($pdo) {
        $this->db = $pdo;
        $this->orderModel = new Order();
        $this->orderItemModel = new OrderItem();
    }

    public function paiement($userId) {
        $cart = $_SESSION['cart'] ?? [];

        if (empty($cart)) {
            throw new Exception("Le panier est vide.");
        }

        $totalAmount = 0;
        foreach ($cart as $item) {
            $totalAmount += $item['price'] * $item['quantity'];
        }

        $orderId = $this->orderModel->create($userId, $totalAmount);

        foreach ($cart as $item) {
            $this->orderItemModel->addItem(
                $orderId,
                $item['produit_id'],
                $item['taille_id'],
                $item['quantity'],
                $item['price']
            );
        }

        unset($_SESSION['cart']);
        
        return $orderId;
    }
}