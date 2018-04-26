<?php

class DB {
  private static $db=null;
  private $dsn = 'mysql:dbname=wwwprosj1;host=127.0.0.1';
  private $user = 'root';
  private $password = '';
  private $dbh = null;

  /* Konstructor, setter PDO tilkobling med dsn, bruker, og passorg */
  private function __construct() {
    try {
        $this->dbh = new PDO($this->dsn, $this->user, $this->password);
    } catch (PDOException $e) {
        // NOTE IKKE BRUK DETTE I PRODUKSJON
        echo 'Connection failed: ' . $e->getMessage();
    }
  }

  /* Danner databasetilkobling om den ikke er satt og returnerer tilkobling */
  public static function getDBConnection() {
      if (DB::$db==null) {
        DB::$db = new self();
      }
      return DB::$db->dbh;
  }
}
