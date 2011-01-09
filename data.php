<?php
require_once("util/startup.php");

require_once("util/dao.php");
try {
	$dao = new ModelDAO($db);
	$model = $dao->build($_GET['id']);
	$action = $_GET['action'];
	if ($action == 'debug') {
		$model->printOut();
		die();
	}
	require("util/data_js.php");
} catch (Exception $e) {
	die($e->getMessage());
}
?>