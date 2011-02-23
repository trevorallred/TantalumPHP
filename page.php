<?php
require_once("util/startup.php");

require_once("util/logging.php");
require_once("util/dao.php");
try {
	$start = DateUtils::getMicrotime();
	$builder = new ViewDAO($db);
	$view = $builder->build($_GET['id']);
	$action = $_GET['action'];
	if ($action == 'debug') {
		$view->printOut();
		die();
	}
	require("util/page_js.php");
	$ms = round(1000 * (DateUtils::getMicrotime() - $start));
	Logging::log("Page", "Loaded " . $view->getName() . " in $ms ms", Logging::TIMING);
} catch (Exception $e) {
	Logging::error("Page", $e->getMessage());
}
?>