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
		try {
			$stores = HtmlUtils::jsonDecode($HTTP_RAW_POST_DATA);
			
			require_once("util/datasaver.php");
			$saver = new DataSaver($db);
			$result = $saver->save($model, $stores);
			echo HtmlUtils::jsonEncode($result);
		} catch (Exception $e) {
			$obj = array();
			$obj["success"] = false;
			$obj["error_message"] = $e->getMessage();
			$obj["error_code"] = $e->getCode();
			echo HtmlUtils::jsonEncode($obj);
		}
		die();
	}

	$data = $dao->getData($model, null);
	
	echo HtmlUtils::jsonEncode($data);
	
} catch (Exception $e) {
	die($e->getMessage());
}

?>