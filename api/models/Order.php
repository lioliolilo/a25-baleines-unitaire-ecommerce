<?php
class Order {
    private PDO $db;

    public function __construct()
    {
        $this->db = Database::getInstance();
    }

    public function create($user_id, $total_amount, $status = 'enattente', $stripe_payment_id = null) {
        $stmt = $this->db->prepare("
            INSERT INTO `order` (user_id, total_amount, status, stripe_payment_id)
            VALUES (:user_id, :total_amount, :status, :stripe_payment_id)
        ");
        $stmt->execute([
            ':user_id' => $user_id,
            ':total_amount' => $total_amount,
            ':status' => $status,
            ':stripe_payment_id' => $stripe_payment_id
        ]);
        return $this->db->lastInsertId();
    }

    public function find($id) {
        $stmt = $this->db->prepare("SELECT * FROM `order` WHERE id = :id");
        $stmt->execute([':id' => $id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getByUser($user_id) {
        $stmt = $this->db->prepare("SELECT * FROM `order` WHERE user_id = :user_id ORDER BY created_at DESC");
        $stmt->execute([':user_id' => $user_id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function updateStatus($order_id, $status) {
        $stmt = $this->db->prepare("UPDATE `order` SET status = :status, updated_at = NOW() WHERE id = :id");
        return $stmt->execute([
            ':status' => $status,
            ':id' => $order_id
        ]);
    }
}
