<?php
require_once "models/Product.php";

class ProductController
{
    private Product $model;

    public function __construct()
    {
        $this->model = new Product();
    }

    public function index()
    {
        return json_encode($this->model->all());
    }

    public function show($id)
    {
        $product = $this->model->find($id);
        if (!$product) {
            http_response_code(404);
            return json_encode(["error" => "Produit introuvable"]);
        }
        return json_encode($product);
    }
}
