<?php
require_once __DIR__ . '/../models/Product.php';

class ProductController
{
    private Product $model;

    public function __construct()
    {
        $this->model = new Product();
    }

    public function showAll()
    {
        return $this->model->all();
    }

    public function show($id)
    {
        $product = $this->model->find($id);
        if (!$product) {
            http_response_code(404);
            return ["error" => "Produit introuvable"];
        }
        return $product;
    }
}
