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
}

?>