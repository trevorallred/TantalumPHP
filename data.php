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
	if ($action == 'save') {
		print_r($_POST);
		die();
	}
	$data = $dao->getData($model, null);

	echo HtmlUtils::jsonEncode($data);
	
} catch (Exception $e) {
	die($e->getMessage());
}

?>