<?php

require_once 'entities.php';
require_once 'sql.php';
require_once 'db.php';
require_once 'common.php';

abstract class BaseDAO {
	/**
	 * @var Database
	 */
	protected $_db;
}

class ModelDAO extends BaseDAO {
	function __construct($db) {
		$this->_db = $db;
	}

	/**
	 * @param String $id View GUID
	 * @return View
	 */
	public function build($id) {
		// Get the top model
		$sql = Model::sql();
		$sql->addWhere("m.id = '$id'");
		$rows = $this->_db->select($sql->sql());
		if (count($rows) == 0) {
			throw new Exception("Could not find Model $id");
		}
		$o = new Model($rows[0]);
		$this->fill($o);

		return $o;
	}

	/**
	 * @param Model $model
	 */
	private function fill($model) {
		$sql = Field::sql();
		$id = $model->getId();
		$sql->addWhere("f.modelID = '$id'");
		// echo "Filling model " . $sql->sql();
		$rows = $this->_db->select($sql->sql());
		foreach ($rows as $row) {
			$field = new Field($row);
			$model->fields[] = $field;
		}
		
		// Get the child models
		$sql = Model::sql();
		$sql->addWhere("m.parentID = '$id'");
		$rows = $this->_db->select($sql->sql());
		foreach ($rows as $row) {
			$o2 = new Model($row);
			$model->childModels[] = $o2;
			$this->fill($o2);
		}
	}
}

class ViewDAO extends BaseDAO {
	function __construct($db) {
		$this->_db = $db;
	}

	/**
	 * @param String $id View GUID
	 * @return View
	 */
	public function build($id) {
		// Get the top view
		$sql = View::sql();
		$sql->addWhere("v.id = '$id'");
		$rows = $this->_db->select($sql->sql());
		if (count($rows) == 0) {
			throw new Exception("Could not find View $id");
		}
		$view = new View($rows[0]);

		$modelID = $view->data["modelID"];
		if (!is_null($modelID)) {
			$dao = new ModelDAO($this->_db);
			$view->model = $dao->build($modelID);
		}
		
		$this->fill($view);

		return $view;
	}

	/**
	 * @param View $view
	 */
	private function fill($view) {
		// Get the child views
		$sql = View::sql();
		$sql->addWhere("v.parentID = '" . $view->getId() . "'");
		$rows = $this->_db->select($sql->sql());
		foreach ($rows as $row) {
			$view2 = new View($row);
			$view->childViews[] = $view2;
			$this->fill($view2);
		}
	}

}

?>