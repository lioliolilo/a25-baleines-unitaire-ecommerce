<?php
class OrderItem {
    private PDO $db;

    public function __construct()
    {
        $this->db = Database::getInstance();
    }

    public function addItem($order_id, $produit_id, $taille_id, $quantity, $price) {
        $stmt = $this->db->prepare("
            INSERT INTO order_items (order_id, produit_id, taille_id, quantity, price)
            VALUES (:order_id, :produit_id, :taille_id, :quantity, :price)
        ");
        return $stmt->execute([
            ':order_id' => $order_id,
            ':produit_id' => $produit_id,
            ':taille_id' => $taille_id,
            ':quantity' => $quantity,
            ':price' => $price
        ]);
    }

    public function getItemsByOrder($order_id) {
        $stmt = $this->db->prepare("
            SELECT oi.*, p.nom, p.type, p.couleur
            FROM order_items oi
            JOIN produits p ON oi.produit_id = p.id
            WHERE order_id = :order_id
        ");
        $stmt->execute([':order_id' => $order_id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
