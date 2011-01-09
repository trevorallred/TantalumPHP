<?php

require_once 'sql.php';
require_once 'db.php';
require_once 'common.php';

abstract class BaseTable {
	public $data = array();

	public function __construct($data) {
		$this->data = $data;
	}

	public function getId() {
		return $this->data["id"];
	}

	public function getName() {
		return $this->data["name"];
	}

	abstract static public function sql();
}

class View extends BaseTable {
	public $childViews = array();
	public $buttons = array();
	/**
	 * @var Model
	 */
	public $model;
	
	public function __construct($data) {
		parent::__construct($data);
	}

	public function printOut() {
		echo "VIEW:<br>";
		HtmlUtils::printTable($this->data);
		echo "<ul>";
		if (count($this->childViews) > 0) {
			foreach ($this->childViews as $o) {
				$o->printOut();
			}
		}
		if (is_object($this->model)) {
			echo "<br>" . $this->model->printOut();
		}
		echo "</ul>";
	}
	
	public function getFields() {
		$fields = array();
		foreach ($this->model->fields as $field) {
			if ($field->data["viewID"] == $this->getId()) {
				$fields[] = $field;
			}
		}
		return $fields;
	}

	/**
	 * @return QueryBuilder
	 */
	static public function sql() {
		$sql = new QueryBuilder();
		$sql->fromTable = "tan_view v";
		$sql->addField("v.id");
		$sql->addField("v.viewType");
		$sql->addField("v.name");
		$sql->addField("v.label");
		$sql->addField("v.parentID");
		$sql->addField("v.modelID");

		return $sql;
	}

}

class Model extends BaseTable {
	public $childModels = array();
	public $references = array();
	public $fields = array();

	public function __construct($data) {
		parent::__construct($data);
	}
	
	public function getPrimaryKey() {
		// TODO make this accurate
		return $this->fields[0];
	}
	
	public function printOut() {
		echo "MODEL:<br>";
		HtmlUtils::printTable($this->data);
		echo "<ul>";
		foreach ($this->references as $o) {
			$o->printOut();
		}
		foreach ($this->fields as $o) {
			$o->printOut();
		}
		foreach ($this->childModels as $o) {
			$o->printOut();
		}
		echo "</ul>";
	}

	/**
	 * @return QueryBuilder
	 */
	static public function sql() {
		$sql = new QueryBuilder();
		$sql->fromTable = "tan_model m";
		$sql->addField("m.id");
		$sql->addField("m.name");
		$sql->addField("m.parentID");
		$sql->addField("m.referenceID");
		$sql->addField("m.allowAdd");
		$sql->addField("m.allowDelete");
		$sql->addField("m.allowEdit");
		$sql->addField("m.resultsPerPage");

		$sql->addLeftJoin("tan_table t ON m.basisTableID = t.id");
		$sql->addField("t.id basisTableID");
		$sql->addField("t.dbName basisTableDbName");

		return $sql;
	}

}

class Field extends BaseTable {
	public function __construct($data) {
		parent::__construct($data);
	}

	public function printOut() {
		echo "FIELD:<br>";
		HtmlUtils::printTable($this->data);
	}

	/**
	 * @return QueryBuilder
	 */
	static public function sql() {
		$sql = new QueryBuilder();
		$sql->fromTable = "tan_field f";
		$sql->addField("f.*");

		$sql->addLeftJoin("tan_column c ON c.id = f.basisColumnID");
		$sql->addField("c.dbName basisColumnDbName");

		$sql->addLeftJoin("tan_table t ON t.id = c.tableID");
		$sql->addField("t.id basisTableID");
		$sql->addField("t.dbName basisTableDbName");

		return $sql;
	}

}

class Reference extends BaseTable {
	public $joinColumns = array();

	public function __construct($data) {
		parent::__construct($data);
	}

	public function printOut() {
		echo "REFERENCE:<br>";
		HtmlUtils::printTable($this->data);
	}

	/**
	 * @return QueryBuilder
	 */
	static public function sql() {
		$sql = new QueryBuilder();
		$sql->fromTable = "tan_reference r";
		$sql->addField("r.*");

		$sql->addJoin("tan_join j ON j.id = joinID");
		$sql->addField("j.joinType");
		$sql->addJoin("tan_join j ON j.id = joinID");

		return $sql;
	}

}

class JoinColumn extends BaseTable {
	public function __construct($data) {
		parent::__construct($data);
	}

	/**
	 * @return QueryBuilder
	 */
	static public function sql() {
		$sql = new QueryBuilder();
		$sql->fromTable = "tan_join_column jc";
		$sql->addField("r.*");

		$sql->addJoin("tan_join j ON j.id = joinID");
		$sql->addField("j.joinType");
		$sql->addJoin("tan_join j ON j.id = joinID");

		return $sql;
	}
}

?>