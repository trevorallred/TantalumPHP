<?php

class HtmlUtils {

	static public function printPre($mixed) {
		echo "<pre>";
		print_r($mixed);
		echo "</pre>";
	}

	static public function printTable($array) {
		echo "<table border=1><tr>";
		foreach ($array as $key=>$value) {
			echo "<td>$key</td>";
		}
		echo "</tr><tr>";
		foreach ($array as $key=>$value) {
			echo "<td>$value</td>";
		}
		echo "</tr></table>";
	}

	static public function jsonEncode($var) {
		if (function_exists("json_encode")) {
			// Use the native PHP method, only available in 5.3+
			return json_encode($var);
		} else {
			// Use the PEAR method
			require_once("Services/JSON.php");
			$json = new Services_JSON();
			return $json->encode($var);
		}
	}

	static public function jsonDecode($var) {
		if (function_exists("json_decode")) {
			// Use the native PHP method, only available in 5.3+
			return json_decode($var);
		} else {
			// Use the PEAR method
			require_once("Services/JSON.php");
			$json = new Services_JSON();
			return $json->decode($var);
		}
	}
}

class DateUtils {
	static function getMicrotime($e = 7) {
		list($u, $s) = explode(' ',microtime());
		return bcadd($u, $s, $e);
	}
}
?>