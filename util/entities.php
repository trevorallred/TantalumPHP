<?php

require_once 'sql.php';
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
	/**
	 * @var View
	 */
	public $parent = null;
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
		if (is_object($this->getModel())) {
			echo "<br>" . $this->getModel()->printOut();
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

	public function getSearchableFields() {
		$fields = array();
		foreach ($this->getFields() as $field) {
			if ($field->data["searchable"]) {
				$fields[] = $field;
			}
		}
		return $fields;
	}
	
	public function getModel() {
		if (empty($this->data["modelID"]))
			return null;
		if (!is_object($this->model)) {
			$this->model = Cache::read("Model", $this->data["modelID"]);
			$this->model->addView($this);
		}
		return $this->model;
	}

	public function isRoot() {
		return $this->parent == null;
	}

	/**
	 * @return SelectSQL
	 */
	static public function sql() {
		$sql = new SelectSQL();
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
	/**
	 * @var Model
	 */
	public $parent = null;
	public $childModels = array();
	public $references = array();
	public $fields = array();
	public $views = array();

	public function __construct($data) {
		parent::__construct($data);
	}

	public function addView($view) {
		if(!in_array($view, $this->views)) {
			$views[] = $view;
		}
	}

	public function getPrimaryKey() {
		// TODO make this accurate
		return $this->fields[0];
	}

	public function findField($columnID) {
		foreach ($this->fields as $field) {
			if ($field->data["basisColumnID"] == $columnID) {
				return $field;
			}
		}
		return null;
	}

	public function findReference($referenceID) {
		if (strlen($referenceID) == 0) {
			return null;
		}
		// TODO put the references in a map so it doesn't take so long to find
		foreach ($this->references as $reference) {
			if ($referenceID == $reference->getId()) {
				return $reference;
			}
		}
		return null;
	}
	
	public function getParentReference() {
		return $this->findReference($this->data["referenceID"]);
	}

	public function printOut() {
		echo "MODEL:<br>";
		HtmlUtils::printTable($this->data);
		if ($this->data["parentID"] > '' && $this->data["referenceID"] == null) {
			echo "<div class='error'>Missing Model ReferenceID</div>";
		}
		echo "<ul>";
		echo "REFERENCES:<br>";
		foreach ($this->references as $o) {
			$o->printOut();
		}
		echo "FIELDS:<br>";
		foreach ($this->fields as $o) {
			$o->printOut();
		}
		foreach ($this->childModels as $o) {
			$o->printOut();
		}
		echo "</ul>";
	}

	/**
	 * @return SelectSQL
	 */
	static public function sql() {
		$sql = new SelectSQL();
		$sql->fromTable = "tan_model m";
		$sql->addField("m.id");
		$sql->addField("m.name");
		$sql->addField("m.parentID");
		$sql->addField("m.referenceID");
		$sql->addField("m.allowAdd");
		$sql->addField("m.allowDelete");
		$sql->addField("m.allowEdit");
		$sql->addField("m.resultsPerPage");
		$sql->addField("m.condition");

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
		HtmlUtils::printTable($this->data);
	}

	/**
	 * @return SelectSQL
	 */
	static public function sql() {
		$sql = new SelectSQL();
		$sql->fromTable = "tan_field f";
		$sql->addField("f.*");

		$sql->addLeftJoin("tan_column c ON c.id = f.basisColumnID");
		$sql->addField("c.dbName basisColumnDbName");
		$sql->addField("c.columnType basisColumnType");

		$sql->addLeftJoin("tan_table t ON t.id = c.tableID");
		$sql->addField("t.id basisTableID");
		$sql->addField("t.dbName basisTableDbName");

		$sql->addLeftJoin("tan_field defaultField ON f.defaultFieldID = defaultField.id");
		$sql->addField("defaultField.name defaultFieldName");

		$sql->addOrderBy("f.displayOrder");

		return $sql;
	}

}

class Reference extends BaseTable {
	private $_fromField = null;
	private $_toField = null;
	public $order = 1;
	
	public $joinColumns = array();
	/**
	 * @var Model
	 */
	public $model;

	public function __construct($data) {
		parent::__construct($data);
	}

	public function printOut() {
		HtmlUtils::printTable($this->data);
		if ($this->model->parent != null) {
			echo "<p>From: ";
			if ($this->getFromField() != null) {
				echo $this->getFromField()->getName();
			}
			echo " To: ";
			if ($this->getToField() != null) {
				echo $this->getToField()->getName();
			}
			echo "</p>";
		}
	}

	public function getFromField() {
		if ($this->_fromField == NULL) {
			if (!is_a($this->model, "Model")) {
				echo "Model isn't set";
			}
			$this->_fromField = $this->model->findField($this->data["fromColumnID"]);
		}
		return $this->_fromField;
	}

	public function getToField() {
		if ($this->_toField == NULL) {
			if (!is_a($this->model, "Model")) {
				echo "Model isn't set";
				return null;
			}
			if (!is_a($this->model->parent, "Model")) {
				echo "Model isn't set";
				return null;
			}
			$this->_toField = $this->model->parent->findField($this->data["toColumnID"]);
		}
		return $this->_toField;
	}

	/**
	 * @return SelectSQL
	 */
	static public function sql() {
		$sql = new SelectSQL();
		$sql->fromTable = "tan_reference r";
		$sql->addField("r.id");
		$sql->addField("r.parentID");
		$sql->addField("r.name");
		$sql->addField("r.joinID");

		$sql->addJoin("tan_join j ON j.id = r.joinID");
		$sql->addField("j.joinType");

		$sql->addJoin("tan_table t ON t.id = j.toTableID");
		$sql->addField("t.id joinToTableID");
		$sql->addField("t.dbName joinToTableDbName");

		$sql->addJoin("tan_join_column jc ON j.id = jc.joinID");
		$sql->addField("jc.fromColumnID");
		$sql->addField("jc.fromText");
		$sql->addField("jc.toColumnID");

		$sql->addLeftJoin("tan_column jfc ON jfc.id = jc.fromColumnID");
		$sql->addField("jfc.dbName fromColumnDbName");
		
		$sql->addJoin("tan_column jtc ON jtc.id = jc.toColumnID");
		$sql->addField("jtc.dbName toColumnDbName");
		
		return $sql;
	}

}

class JoinColumn extends BaseTable {
	public function __construct($data) {
		parent::__construct($data);
	}

	/**
	 * @return SelectSQL
	 */
	static public function sql() {
		$sql = new SelectSQL();
		$sql->fromTable = "tan_join_column jc";
		$sql->addField("r.*");

		$sql->addJoin("tan_join j ON j.id = joinID");
		$sql->addField("j.joinType");
		$sql->addJoin("tan_join j ON j.id = joinID");

		return $sql;
	}
}

class ColumnTypes {
	static public function getValues() {
		$values = array("UUID","String","Boolean","Integer","CreatedBy","UpdatedBy","CreationDate","UpdateDate","UpdateProcess");
		return $values;
	}

	static public function printValues() {
		$values = ColumnTypes::getValues();
		for ($i = 0; $i < count($values); $i++) {
			echo ($i > 0 ? "," : "") . "['" . $values[$i] . "']";
		}
	}
}

?>