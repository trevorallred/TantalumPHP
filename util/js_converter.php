<?php

class JavaScriptArray {
	private $_list = array();

	public function add($value) {
		$o = new JavaScriptValue($value);
		$this->_list[] = $o;
	}

	public function addRaw($value) {
		$o = new JavaScriptValue($value, JavaScriptValue::RAW);
		$this->_list[] = $o;
	}
	
	public function addAll($values) {
		if (is_a($values, "JavaScriptArray")) {
			$values = $values->getList();
		}
		foreach ($values as $key=>$value) {
			$this->_list[] = $value;
		}
	}
	
	public function getList() {
		return $this->_list;
	}

	public function printOut() {
		$out = "[";
		for ($i = 0; $i < count($this->_list); $i++) {
			if ($i > 0) {
				$out .= ",";
			}
			$out .= $this->_list[$i]->printOut();
		}
		$out .= "]";
		return $out;
	}
}

class JavaScriptValue {
	private $_type;
	private $_value;
	const STRING = "STRING";
	const NUMBER = "NUMBER";
	const JAVASCRIPT = "JAVASCRIPT";
	const BOOLEAN = "BOOLEAN";
	const RAW = "RAW";

	public function __construct($value, $type = NULL) {
		$this->_value = $value;
		if ($type == NULL) {
			if(is_null($value)) {
				$type = JavaScriptValue::RAW;
			}
			if(is_string($value)) {
				$type = JavaScriptValue::STRING;
			}
			if(is_numeric($value)) {
				$type = JavaScriptValue::NUMBER;
			}
			if(is_bool($value)) {
				$type = JavaScriptValue::BOOLEAN;
			}
		}
		$this->_type = $type;
	}

	public function printOut() {
		if($this->_type == JavaScriptValue::STRING) {
			$value = str_replace('"', '\"', $this->_value);
			return '"' . $value . '"';
		}
		if($this->_type == JavaScriptValue::BOOLEAN) {
			return $this->_value ? "true" : "false";
		}
		if($this->_value == NULL)
		return "null";
		if(is_object($this->_value)) {
			return $this->_value->printOut();
		}
		return $this->_value;
	}
}

class JavaScriptObject {
	private $_list = array();

	/**
	 * @param String $name
	 * @param JavaScriptValue $value
	 */
	public function add($name, $value, $type=NULL) {
		if (!is_object($value)) {
			$value = new JavaScriptValue($value, $type);
		}
		$this->_list[$name] = $value;
	}

	/**
	 * @param String $name
	 * @param JavaScriptValue $value
	 */
	public function addRaw($name, $value) {
		$this->_list[$name] = new JavaScriptValue($value, JavaScriptValue::RAW);
	}

	public function printOut() {
		$out = "";
		foreach ($this->_list as $name=>$value) {
			if (strlen($out) > 0) {
				$out .= ", ";
			}
			$out .= '"' . $name . '": ';
			$out .= $value->printOut();
		}
		return "{" . $out . "}";
	}
}

?>