<?php
require_once __DIR__ . '/../models/Order.php';
require_once __DIR__ . '/../models/OrderItem.php';

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
            $totalAmount += $item['prix'] * $item['quantity'];
        }

        $orderId = $this->orderModel->create($userId, $totalAmount);

        foreach ($cart as $item) {
            $produit_id = $item['id'] ?? null;
            $price = $item['prix'] ?? null;
            $quantity = $item['quantity'] ?? 1;

            $taille_id = null;
            if (!empty($item['taille'])) {
                $stmt = $this->db->prepare("SELECT id FROM tailles WHERE code = ?");
                $stmt->execute([$item['taille']]);
                $taille_id = $stmt->fetchColumn();
            }

            if (!$produit_id || !$price) {
                throw new Exception("Produit ou prix manquant");
            }

            $this->orderItemModel->addItem(
                $orderId,
                $produit_id,
                $taille_id,
                $quantity,
                $price
            );
        }

        unset($_SESSION['cart']);

        return $orderId;
    }
}