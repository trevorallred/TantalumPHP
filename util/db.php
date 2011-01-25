<?php
if (!file_exists('config/settings.php')) {
  header("Location: install/index.php");
}
$SETS = parse_ini_file("config/settings.php",true);
$connection = Database::getConnection($SETS['db']);
if ($connection == null)
	die("Failed to connect to Database");
$db = new Database($connection);

/**
 * General Database Access Layer for Tantalum
 * @author Trevor
 *
 */
class Database {
	private $_connection;
	private $_error;

	/**
	 * @param mysqli $connection
	 */
	function __construct($connection) {
		$this->_connection = $connection;
	}

	static public function getConnection($settings) {
		$conn = new mysqli($settings['server'], $settings['username'], $settings['password'], $settings['database']);

		if (mysqli_connect_errno()) {
			// $this->_error = "Connect failed: " . mysqli_connect_error();
			return false;
		}
		return $conn;
	}

	public function select($sql) {
		$query = $this->_connection->query($sql);
		if (!$query) {
			throw new Exception(mysqli_error($this->_connection) . ": $sql");
		}

		$rows = array();
		while($r=$query->fetch_assoc()) {
			$rows[] = $r;
		}
		return $rows;
	}
	
	public function update($sql) {
		$query = $this->_connection->query($sql);
		if (!$query) {
			throw new Exception(mysqli_error($this->_connection) . ": $sql");
		}
	}
	
	public function UUID() {
		$query = $this->_connection->query("SELECT UUID() id");
		
		if (!$query) {
			throw new Exception(mysqli_error($this->_connection) . ": $sql");
		}

		$r = $query->fetch_assoc();
		return $r["id"];
	}
	
	public function getError() {
		return $this->_error;
	}

}

?>