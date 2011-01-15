<?php
class Cache {
	/**
	 * @var array()
	 */
	static public $data = array();
	
	/**
	 * Store data
	 *
	 * @param string $group Group to store data under
	 * @param string $id    Unique ID of this data
	 */
	public static function write($group, $id, $obj) {
		self::$data[$group][$id] = $obj;
	}

	/**
	 * Reads data
	 *
	 * @param string $group Group to store data under
	 * @param string $id    Unique ID of this data
	 */
	public static function read($group, $id)
	{
		return self::$data[$group][$id];
	}
}
?>