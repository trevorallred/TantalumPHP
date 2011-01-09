<?php
require_once("util/startup.php");

require_once("util/dao.php");
try {
	$builder = new ViewDAO($db);
	$view = $builder->build($_GET['id']);
	$action = $_GET['action'];
	if ($action == 'debug') {
		$view->printOut();
		die();
	}
	require("util/page_js.php");
} catch (Exception $e) {
	die($e->getMessage());
}
?>