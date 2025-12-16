<?php

class Database
{
    private static ?PDO $pdo = null;

    public static function getInstance(): PDO
    {
        if (self::$pdo === null) {
            $host = "localhost";
            $dbname = "rich_ricasso_shop";
            $user = "root";
            $pass = "";

            try {
                self::$pdo = new PDO(
                    "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
                    $user,
                    $pass,
                    [
                        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    ]
                );
            } catch (PDOException $e) {
                http_response_code(500);
                echo json_encode([
                    "error" => "Erreur connexion BD",
                    "details" => $e->getMessage()
                ]);
                exit;
            }
        }

        return self::$pdo;
    }
}
