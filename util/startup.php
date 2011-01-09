<?php
if (!file_exists('config/settings.php')) {
	header("Location: install/index.php");
}
$SETS = parse_ini_file("config/settings.php",true);

if ($SETS['logging']['error_reporting'] == "E_ALL") {
	error_reporting(E_ALL);
} else {
	error_reporting(E_ERROR);
}

require_once 'db.php';
$connection = Database::getConnection($SETS['db']);
if ($connection == null)
die("Failed to connect to Database");
$db = new Database($connection);

?>