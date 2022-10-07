<?php

  $servername = 'localhost';
  $username = 'root';
  $password = '';
  $dbname = 'testdb';
  $table = 'factura';

  $action = $_POST['action'];

  $conn = new mysqli($servername, $username, $password, $dbname);

  if($conn->connect_error){

    die("Error: ". $conn->connect_error);
    return;

  }

  if("CREATE_TABLE" == $action){

    $sql = "CREATE TABLE IF NOT EXISTS $table (
        id INT(6) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        total DECIMAL(18,2) NULL)";
    
    if($conn->query($sql) === TRUE){

        echo "success";
    }else{
        echo "error";
    }

    $conn->close();

    return;

  }


  if("GET_ALL" == $action){

    $db_data = array();
    $sql = "SELECT id, fecha, total FROM $table ORDER BY id DESC";
    $result = $conn->query($sql);

    if($result->num_rows() > 0){

        while($row = $result->fetch_assoc()){

            $db_data[] = $row;
        }

        echo json_encode($db_data);
    }else{

        echo "error";
    }

    $conn->close();

    return;

  }


  if("ADD_FACT" == $action){

    $total = $_POST["total"];
    $sql = "INSERT INTO $table (total) VALUES ('$total')";
    $result = $conn->query($sql);

    echo"success";
    $conn->close();

    return;
  }

  if("UPDATE_FACT" == $action){

    $id = $_POST['$id'];
    $total = $_POST["total"];
    $sql = "UPDATE $table SET total='$total' WHERE id=$id";

    if($conn->query($sql) === TRUE){

        echo"success";

    }else{
        echo"error";
    }
    $conn->close();

    return;
  }

  if("DELETE_FACT" == $action){

    $id = $_POST['$id'];
    $sql = "DELETE FROM $table WHERE id=$id";

    if($conn->query($sql) === TRUE){

        echo"success";

    }else{
        echo"error";
    }
    $conn->close();

    return;

  }







?>