<?php

class Database {
    private $host = "localhost";
    private $db_name = "db_gtb";
    private $username = "root";
    private $password = "12345678";

    // Get the database connection
    public function getConnection() {
        try {
            $conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);
            $conn->exec("set names utf8");
            echo "เชื่อมต่อสำเร็จ"; // ข้อความนี้จะถูกแสดงหากเชื่อมต่อสำเร็จ
        } catch(PDOException $exception) {
            echo "Connection error: " . $exception->getMessage();
        }
    }
}
?>
