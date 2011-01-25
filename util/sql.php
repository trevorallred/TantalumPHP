<?php

class SelectSQL {
	public $fromTable;
	private $fields = array();
	private $joinClause = array();
	public $whereClause = array();
	private $orderBys = array();
	public $startRow = 0;
	public $limit = -1;

	/**
	 * Return the sql clause in this format:
	 *
	 * SELECT {fields<String>} FROM {fromTable} [{joinClause<String>}] [WHERE
	 * {whereClause}] [GROUP BY {groupByFields<String>] [HAVING {havingClause}]
	 * [ORDER BY {orderBys<String>} [LIMIT {limit}|LIMIT {startRow}, {limit}]
	 */
	public function sql() {
		$sql = "SELECT ";
		if (count($this->fields) > 0) {
			$sql .= implode(", ", $this->fields);
		} else {
			$sql .= "*";
		}
		$sql .= "\nFROM " . $this->fromTable;

		if (count($this->joinClause) > 0) {
			$sql .= "\n" . implode("\n", $this->joinClause);
		}

		if (count($this->whereClause) > 0) {
			$sql .= "\nWHERE (" . implode(") AND (", $this->whereClause) . ")";
		}
		if (count($this->orderBys) > 0) {
			$sql .= "\nORDER BY ";
			$sql .= implode(", ", $this->orderBys);
		}

		if ($this->limit >= 0) {
			$sql .= "\nLIMIT ";
			if ($this->startRow > 0) {
				$sql .= $this->startRow . ", ";
			}
			$sql .= $this->limit;
		}
		return $sql;
	}

	public function addField($name) {
		$this->fields[] = $name;
	}

	/**
	 * Add "JOIN $join"
	 * @param String $join Example: table t2 ON t2.id = t1.id
	 */
	public function addJoin($join) {
		$this->joinClause[] = "JOIN " . $join;
	}

	/**
	 * Add "LEFT JOIN $join" to query
	 * @param String Example: table t2 ON t2.id = t1.id
	 */
	public function addLeftJoin($join) {
		$this->joinClause[] = "LEFT JOIN " . $join;
	}

	public function addWhere($where) {
		if (empty($where)) {
			return;
		}
		$this->whereClause[] = $where;
	}

	public function addOrderBy($column, $asc=TRUE) {
		$this->orderBys[] = $column . ($asc ? "" : " DESC");
	}

}

class UpdateSQL {
	public $fromTable;
	private $fields = array();
	public $whereClause = array();
	public $limit = -1;
	public $insert = FALSE;

	/**
	 * @param String $fromTable The database table to update
	 */
	public function __construct($fromTable) {
		$this->fromTable = $fromTable;
	}

	/**
	 * Return the sql clause in this format:<br>
	 * <br>
	 * UPDATE {table} SET {field='<String>'} [,{field='<String>'}...] [WHERE
	 * {whereClause}] [LIMIT {limit}]<br>
	 * OR<br>
	 * INSERT INTO {table} SET {fields<String>}
	 */
	public function sql() {
		$sql = "";

		if ($this->insert) {
			$sql = "INSERT INTO ";
		} else {
			$sql = "UPDATE ";
		}
		$sql .= $this->fromTable . " SET ";

		$first = TRUE;

		foreach ($this->fields as $key=>$value) {
			if ($first) {
				$first = FALSE;
			} else {
				$sql .= ", ";
			}

			$sql .= "\n" . $key ." = ";
			if ($value == null)
				$sql .= "NULL";
			else if ($value == "NOW()")
				$sql .= $value;
			else
				$sql .= "'".$value."'";
		}

		if (!$this->insert) {
			if (count($this->whereClause) > 0) {
				$sql .= "\nWHERE (" . implode(") AND (", $this->whereClause) . ")";
			}

			if ($this->limit >= 0) {
				$sql .= "\nLIMIT ";
				$sql .= $this->limit;
			}
		}
		return $sql;
	}

	public function addField($name, $value) {
		$this->fields[$name] = $value;
	}

	public function addWhere($where) {
		if (empty($where)) {
			return;
		}
		$this->whereClause[] = $where;
	}
}

?>