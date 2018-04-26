<?php

require_once "DB.php";


class User {
  //private $uid = -1;
  private $db = null;

  public function __construct($db) {
    $this->db = $db;

  }

  public function login($data) {
    $tmp = [];
    try {
      $sql = 'SELECT * FROM bruker WHERE brukernavn=?';
      $sth = $this->db->prepare($sql);
      $sth->execute(array($data['uname']));
      $res = $sth->fetch(PDO::FETCH_ASSOC);
      if ($res['brukernavn'] == $data['uname']) {
        if (password_verify($data['pword'], $res['passord'])) {
          $this->uid = $res['id'];
          $_SESSION['uid'] = $this->uid;
          $tmp["laerer"] = $res["laerer"];
          $tmp["student"] = $res["student"];
          $tmp["vilBliLaerer"] = $res["vilBliLaerer"];
          $tmp['status'] = "OK";
        }
        else { $tmp['status'] = "ERROR"; $tmp['errorMelding'] = "Feil passord"; }
      }
      else { $tmp['status'] = "ERROR"; $tmp['errorMelding'] = "Feil bukernavn"; }
    }
    catch (PDOException $e) {
      // NOTE IKKE BRUK DETTE I PRODUKSJON
      echo 'Connection failed: ' . $e->getMessage();
    }
    return $tmp;
  }
}
