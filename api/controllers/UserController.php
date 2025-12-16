<?php
require_once "models/User.php";

class UserController
{
    private User $model;

    public function __construct()
    {
        $this->model = new User();
    }

    public function store()
    {
        $data = json_decode(file_get_contents("php://input"), true);

        if (!$data['email'] || !$data['password']) {
            http_response_code(400);
            return json_encode(["error" => "Données invalides"]);
        }

        $this->model->create(
            $data['email'],
            $data['username'] ?? '',
            $data['password']
        );

        http_response_code(201);
        return json_encode(["message" => "Utilisateur créé"]);
    }

    public function login()
    {
        $data = json_decode(file_get_contents("php://input"), true);
        $user = $this->model->findByEmail($data['email']);

        if (!$user || !password_verify($data['password'], $user['password'])) {
            http_response_code(401);
            return json_encode(["error" => "Identifiants invalides"]);
        }

        return json_encode([
            "message" => "Connexion réussie",
            "user" => [
                "id" => $user['id'],
                "email" => $user['email'],
                "username" => $user['username']
            ]
        ]);
    }
}
