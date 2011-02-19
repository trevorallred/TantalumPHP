<?php
require_once 'entities.php';
require_once 'dao.php';

class DataSaver extends BaseDAO {

	function __construct($db) {
		$this->_db = $db;
	}

	/**
	 * @param Model $model
	 * @param unknown_type $store
	 */
	public function save($model, $stores) {
		if ($stores == null) {
			return;
		}

		$modelName = $model->getName();
		$primaryKeyField = $model->getPrimaryKey();
		if ($primaryKeyField == null) {
			return;
		}
		$primaryKeyFieldName = $primaryKeyField->getName();

		$store = $stores->$modelName;

		if (count($store->destroy)) {
			$ids = array();
			foreach ($store->destroy as $row) {
				$ids[] = "'" . $row->$primaryKeyFieldName . "'";
			}

			$sql = "DELETE FROM " . $model->data["basisTableDbName"] . " WHERE " . $primaryKeyField->data["basisColumnDbName"] . " IN (" . implode(",", $ids) . ")";
			$this->_db->update($sql);
		}

		if (count($store->create)) {
			foreach ($store->create as $row) {
				$sql = new UpdateSQL($model->data["basisTableDbName"]);
				$sql->insert = TRUE;
				foreach ($model->fields as $field) {
					$fieldName = $field->getName();
					if ($field->data["basisColumnID"] != null) {
						if ($field->data["referenceID"] == null) {

							$saveField = TRUE;
							$value = NULL;

							switch ($field->data["basisColumnType"]) {
								case "AutoIncrement":
									$saveField = FALSE;
									break;
								case "UUID":
									$value = $this->_db->UUID();
									$row->$fieldName = $value;
									break;
								default:
									$value = $row->$fieldName;
									break;
							}

							if ($saveField) {
								$sql->addField($field->data["basisColumnDbName"], $value);
							}

						}

					}
				}
				$this->_db->update($sql->sql());
				// echo $sql->sql();
				// $key = $this->_db->getGeneratedKey();
				// $row->$primaryKeyFieldName = $key;
			}
		}


		if (count($store->update)) {

			foreach ($store->update as $row) {
				$sql = new UpdateSQL($model->data["basisTableDbName"]);

				foreach ($model->fields as $field) {
					if ($field->data["basisColumnID"] != null) {
						$fieldName = $field->getName();
						// echo $fieldName . "<br>";
						if ($field->data["referenceID"] == null && isset($row->$fieldName)) {
							$primaryKey = FALSE;

							if ($primaryKeyField == $field) {
								$primaryKey = TRUE;
							}
							/*
							 for (MetaIndex index : field.getBasisColumn().getTable().getIndexes()) {
								if (index.isUniqueIndex()) {
								for (MetaIndexColumn indexColumn : index.getColumns()) {
								if (indexColumn.getColumn() == field.getBasisColumn())
								primaryKey = true;
								}
								}
								}
								*/
							if ($primaryKey) {
								// TODO escape quotes or use binding
								$where = $field->data["basisColumnDbName"] . " = '" . $row->$fieldName . "'";
								$sql->addWhere($where);
							} else if ($field->data["editable"] == 1) {
								$value = null;
								$saveField = TRUE;
								/*
								 if (field.getBasisColumn().getColumnType().isWho()) {
									switch (field.getBasisColumn().getColumnType()) {
									case CreatedBy:
									saveField = false;
									break;
									case UpdatedBy:
									if (currentUserID == null) {
									System.out
									.println("WARNING: Remember to setCurrentUserID() before calling save");
									value = null;
									} else {
									value = currentUserID.toString();
									}
									break;
									case CreationDate:
									saveField = false;
									break;
									case UpdateDate:
									value = Strings.formatDateTime(now);
									break;
									default:
									if (currentProcess == null) {
									System.out
									.println("WARNING: Remember to setCurrentProcess() before calling save");
									value = "UNKNOWN";
									} else {
									value = currentProcess;
									}
									}
									} else if (field.getBasisColumn().getColumnType() == ColumnType.AutoIncrement) {
									saveField = false;
									} else {
									value = instance.getStringForDB(field);
									}
									*/
								$value = $row->$fieldName;
								if ($saveField) {
									$sql->addField($field->data["basisColumnDbName"], $value);
								}
							}

						}
					}
				}
				$this->_db->update($sql->sql());
			}
		}
		return $stores;
	}
}

?>