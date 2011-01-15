<?php

class QueryBuilder {
	public $fromTable;
	private $fields = array();
	private $joinClause = array();
	public $whereClause = array();
	public $orderBys = array();
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

}

?>