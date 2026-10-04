<?php
   ob_start();
   session_start();
   $hostname="localhost";
   $username="root";
   $password="CTF_DB_PASSWORD";

   $dbhandle=mysql_connect($hostname, $username, $password) or die("Unable to connect to MySQL");

   $selected = mysql_select_db("products", $dbhandle) or die("Could not select db products");

?>

<html>
 <head>
  <title>SIS Online Shop</title>
 </head>
 <body>

 <h1>Welcome to the SIS Online Store</h1>

<?php if(isset($_SESSION["username"])) echo "<p>Welcome ". $_SESSION["username"]. "<a href='logout.php'>Logout</a></p>";
else echo "<p>You are no stranger to us. Please login <a href=\"login.php\">here</a></p>";
?>


    <?php if(isset($_GET['id'])) {
        $query = "select * from products where id=".$_GET['id'];
        $result=mysql_query($query);
        $row = mysql_fetch_array($result);
        if (!$row) echo "<p> Unable to find product with ID ". $_GET['id'] ."</p>";
        else
            {
        ?>
        <table>
        <th>
            <th>Name</th>
            <th>Price</th>
            <th>Description</th>
        </th>
        <tr>
            <td> <?php echo $row{'name'}; ?></td>
            <td> <?php echo $row{'PRICE'}."$"; ?></td>
            <td> <?php echo $row{'description'} ?></td>
         <?php }
   } 
    else {
        ?>
    
    <h2> Here are our products: </h2>
    <?php 
    $query = "select id, name from products";
    $result=mysql_query($query);
    while ($row = mysql_fetch_assoc($result)) {
        echo "<a href=\"" .$_SERVER['PHP_SELF'] ."?id=" .$row['id']. "\">" . $row['name'] . "</a><br/>";

    }
    }
    ?>
</body>
</html>
