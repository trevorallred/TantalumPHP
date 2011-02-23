<?php

require_once 'db.php';
require_once 'sql.php';

class Logging {
	const INFO = "info";
	const WARNING = "warning";
	const ERROR = "error";
	const TIMING = "timing";

	static public function error($scope, $message) {
		Logging::log($scope, $message, Logging::ERROR);
	}
	
	static public function log($scope, $message, $type=Logging::INFO) {
		global $db;
		try {
			$sql = new UpdateSQL("tan_logging");
			$sql->insert = true;
			$sql->addField("scope", $scope);
			$sql->addField("logType", $type);
			$sql->addField("message", $message);
			$db->update($sql->sql());
		} catch (Exception $e) {

		}
	}
}

?>