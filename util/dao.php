<?php

require_once 'entities.php';
require_once 'sql.php';
require_once 'tql.php';
require_once 'db.php';
require_once 'common.php';
require_once 'cache.php';

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
		$id = $model->getId();
		
		$sql = Field::sql();
		$sql->addWhere("f.modelID = '$id'");
		$rows = $this->_db->select($sql->sql());
		$fieldIDs = array();
		foreach ($rows as $row) {
			$field = new Field($row);
			$model->fields[] = $field;
			$fieldIDs[] = $field->getId();
		}

		if (count($fieldIDs) > 0) {
			$fieldIDs = SelectSQL::appendIDs($fieldIDs);
			
			$sql = FieldAction::sql();
			$sql->addWhere("f.fieldID IN (" . $fieldIDs . ")");
			$rows = $this->_db->select($sql->sql());
			foreach ($rows as $row) {
				$fieldAction = new FieldAction($row);
				//$field = $model->findByID();
			}
			
			$sql = FieldActionDetail::sql();
			$sql->addWhere("f.fieldID IN (" . $fieldIDs . ")");
			$rows = $this->_db->select($sql->sql());
			//echo $sql->sql() . "; <p>";
			foreach ($rows as $row) {
				$fieldActionDetail = new FieldActionDetail($row);
				
				$fieldActionID = $fieldActionDetail->data["fieldActionID"];
				$fieldID = $fieldActionDetail->data["fieldID"];
				if ($fieldActionID > '') {
					
				} else if ($fieldID > '') {
					$field = $model->findByID($fieldID);
					$field->fieldDetails[] = $fieldActionDetail;
				}
			}
		}
		
		$sql = Reference::sql();
		$sql->addWhere("r.modelID = '$id'");
		// echo "<p>".$model->getName() . $sql->sql();
		$rows = $this->_db->select($sql->sql());
		$referenceOrder = 1;
		// TODO Make sure the parentID already exists before adding it to model->references
		// Otherwise we'll get a query that does a join to a later table
		foreach ($rows as $row) {
			$o2 = new Reference($row);
			$o2->model = $model;
			$o2->order = $referenceOrder;
			$model->references[] = $o2;
			$referenceOrder++;
		}
		
		// Get the child models
		$sql = Model::sql();
		$sql->addWhere("m.parentID = '$id'");
		$rows = $this->_db->select($sql->sql());
		foreach ($rows as $row) {
			$o2 = new Model($row);
			$o2->parent = $model;
			$model->childModels[] = $o2;
			$this->fill($o2);
		}
		Cache::write("Model", $model->getId(), $model);
	}
	/**
	 * 
	 * @param Model $model
	 * @param unknown_type $parents
	 */
	public function getData($model, $parents, $condition) {
		// echo "<p>MODEL: " . $model->getName() . "<br>";
		$sql = new SelectSQL();
		$sql->fromTable = $model->data['basisTableDbName'] . " t0";

		// Add the JOINs
		foreach ($model->references as $reference) {
			// echo $reference->printOut();
			$fromTableOrder = 0;
			$parentReference = $model->findReference($reference->data['parentID']);
			if ($parentReference != null) {
				$fromTableOrder = $parentReference->order;
			}
			$join = $reference->data['joinToTableDbName'] . " t" . $reference->order ." 
				ON t${fromTableOrder}." . $reference->data['fromColumnDbName'] . " = t" . $reference->order . "." . $reference->data['toColumnDbName'];
			$sql->addLeftJoin($join);
		}
		
		// Add the COLUMNs
		$sorting = array();
		foreach ($model->fields as $column) {
			$t = 0;
			if(strlen($column->data["referenceID"]) > 0) {
				$reference = $model->findReference($column->data["referenceID"]);
				$t = $reference->order;
			}
			
			$sql->addField("t${t}." . $column->data['basisColumnDbName'] . " AS " . $column->data['name']);
			
			if ($column->data["sortOrder"] > 0) {
				$sorting[] = $column;
			}
		}
		
		// Add ORDER BYs
		if (count($sorting) > 0) {
			usort($sorting, "fieldSortOrder");
			foreach ($sorting as $column) {
				$sql->addOrderBy($column->data['name'], $column->data['sortDirection'] != "DESC");
			}
			//HtmlUtils::printPre($sorting);
		}
				
		// Add Where Clause
		if ($condition > '') {
			$sql->addWhere(TQL::parse($condition, $model));
		}
		if ($model->data['condition'] > '') {
			$sql->addWhere(TQL::parse($model->data['condition'], $model));
		}
		$ref = $model->getParentReference();
		if ($ref != null) {
			// echo $ref->printOut() . "<p>Count " . count($parents);
			if (count($parents) == 0) {
				$data[$model->data['name']] = array();
				return $data;
			}
			
			$toField = $ref->getToField();
			
			$ids = array();
			foreach ($parents as $row) {
				$ids[] = "'".$row[$toField->getName()]."'";
			}
			$sql->addWhere("t0." . $ref->getFromField()->data["basisColumnDbName"] . " IN (" . implode(", ", $ids) . ")");
		}
		
		// Query Data
		// echo "<p>" . $sql->sql() . "</p>";
		$data[$model->data['name']] = $this->_db->select($sql->sql());
		
		foreach ($model->childModels as $childModel) {
			$d2 = $this->getData($childModel, $data[$model->data['name']]);
			foreach ($d2 as $key=>$value) {
				$data[$key] = $value;
			}
		}
		
		return $data;
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
			$model = $dao->build($modelID);
		}
		$this->fill($view);

		return $view;
	}

	/**
	 * Fill in the models for each View
	 * @param Model $model
	 */
	private function indexModels($model) {
		if ($view->data["modelID"] == $model->getId()) {
			$view->model = $model;
		}
		$index = array();
		
		$index[$model->getId()] = $model;
		foreach ($model->childModel as $child) {
			$indexOfChildren = $this->indexModels($child);
			$index = array_merge($index, $indexOfChildren);
		}
		return $index;
	}
	
	/**
	 * @param View $view
	 */
	private function fill($view) {
		// Get the child views
		$sql = View::sql();
		$sql->addWhere("v.parentID = '" . $view->getId() . "'");
		$sql->addOrderBy("displayOrder");
		$rows = $this->_db->select($sql->sql());
		foreach ($rows as $row) {
			$view2 = new View($row);
			$view2->parent = $view;
			$view->childViews[] = $view2;
			$this->fill($view2);
		}
	}

}

class MenuDAO extends BaseDAO {
	function __construct($db) {
		$this->_db = $db;
	}

	/**
	 * @param String $id View GUID
	 * @return View
	 */
	public function build($id) {
		// Get the top menu
		$sql = Menu::sql();
		$sql->addWhere("m.id = '$id'");
		$rows = $this->_db->select($sql->sql());
		if (count($rows) == 0) {
			throw new Exception("Could not find Menu $id");
		}
		$o = new Menu($rows[0]);
		$o->subMenus = $this->getSubMenus($o);
		//$o->printOut();
		
		return $o;
	}
	
	public function getSubMenus($menu) {
		$sql = Menu::sql();
		$sql->addWhere("m.parentID = '" . $menu->getId() . "'");
		//echo $sql->sql();
		$rows = $this->_db->select($sql->sql());
		$subMenus = array();
		foreach ($rows as $row) {
			//print_r($row);
			$subMenu = new Menu($row);
			if ($subMenu->data["viewID"] == null) {
				$subMenu->subMenus = $this->getSubMenus($subMenu);
			}
			$subMenus[] = $subMenu;
			//$subMenu->printOut();
		}
		//echo "<p>" . count($menu->subMenus) . "</p>";
		return $subMenus;
	}
}

/**
 * @param Field $a
 * @param Field $b
 */
function fieldSortOrder($a, $b) {
	return $a->data["sortOrder"] - $b->data["sortOrder"];
}


?>