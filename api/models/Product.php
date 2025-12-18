<?php
require_once __DIR__ . '/../config/Database.php';

class Product
{
    private PDO $db;

    public function __construct()
    {
        $this->db = Database::getInstance();
    }

    public function allWithTailles()
    {
        $stmt = $this->db->query("SELECT * FROM produits");
        $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $stmt = $this->db->query("
            SELECT pt.produit_id, t.id AS taille_id, t.label
            FROM produit_taille pt
            JOIN tailles t ON pt.taille_id = t.id
        ");
        $taillesData = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $taillesByProduct = [];
        foreach ($taillesData as $row) {
            $taillesByProduct[$row['produit_id']][] = [
                'id' => $row['taille_id'],
                'label' => $row['label']
            ];
        }

        foreach ($products as &$p) {
            $p['tailles'] = $taillesByProduct[$p['id']] ?? [['id' => 12, 'label' => 'Unique']];
        }

        return $products;
    }

    public function findWithTailles($id)
    {
        $stmt = $this->db->prepare("SELECT * FROM produits WHERE id = :id");
        $stmt->execute(['id' => $id]);
        $product = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$product) return null;

        $stmt = $this->db->prepare("
            SELECT t.id AS taille_id, t.label
            FROM produit_taille pt
            JOIN tailles t ON pt.taille_id = t.id
            WHERE pt.produit_id = :id
        ");
        $stmt->execute(['id' => $id]);
        $tailles = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $product['tailles'] = $tailles ?: [['id' => 12, 'label' => 'Unique']];

        return $product;
    }
}
