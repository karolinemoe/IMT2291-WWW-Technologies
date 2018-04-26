<?php
/**
 * This script is used for logging in/out and checking for logged in status.
 * If called with method POST it is used to log users in to the system.
 * If called with method GET and the variable 'logoug' set it logs the user out.
 * If none of the above the $_SESSION variable is used to determine is a users
 * is logged in or not.
 */

require_once 'config.php';
require_once '../classes/DB.php';
require_once '../classes/User.php';

session_start();

header("Access-Control-Allow-Origin: ".$config['AccessControlAllowOrigin']);
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Origin");
header("Content-Type: application/json; charset=utf-8");

if (isset($_POST['uname']) and isset($_POST['pword'])) {             // Logging in (always successfull)
  $db = DB::getDBConnection();
  $user = new User($db);

  $data['uname'] = $_POST['uname'];
  $data['pword'] = $_POST['pword'];

  $res = $user->login($data);
  if ($res['status'] == "OK") {
    $_SESSION['uname'] = $_POST['uname'];

    if($res["laerer"] == 1){
      $_SESSION['utype'] = $res["laerer"];
      echo json_encode(array('type'=>$_SESSION['utype'], 'uname'=>$_SESSION['uname']));
    }
    else if($res["admin"] == 1){
      $_SESSION['utype'] = $res["admin"];
      echo json_encode(array('type'=>$_SESSION['utype'], 'uname'=>$_SESSION['uname']));

    }
    else{
      $_SESSION['utype'] = 1;
      echo json_encode(array('type'=>$_SESSION['utype'], 'uname'=>$_SESSION['uname']));

    }
  } else
      echo json_encode(array('type'=>0));

} else if (isset($_GET['logout'])) {      // Logging out
  unset ($_SESSION['utype']);
  echo json_encode(array('type'=>0));
} else if (isset($_SESSION['utype'])) {   // Logged in
  echo json_encode(array('type'=>$_SESSION['utype'], 'uname'=>$_SESSION['uname']));
} else {                                  // Not logged in
  echo json_encode(array('type'=>0));
}
?>
