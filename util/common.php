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
			echo json_encode($var);
		} else {
			// Use the PEAR method
			require_once("Services/JSON.php");
			$json = new Services_JSON();
			echo $json->encode($var);
		}
	}
}

?>