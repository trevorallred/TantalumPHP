<?php

class TQL {
	/**
	 * @param String $condition
	 * @param Model $model
	 */
	static function parse($condition, $model) {
		$condition = trim($condition);
		preg_match('/\((.+[ AND | OR ].+)\)( AND | OR )\((.+[ AND | OR ].+)\)/', $condition, $matches, PREG_OFFSET_CAPTURE);
		// print_r($matches);
		
		if (count($matches) > 0) {
			// echo " found matches $condition <p>";
			$where = "(";
			$where .= TQL::parse(trim($matches[1][0]), $model);
			$where .= ")";
			$where .= $matches[2][0];
			$where .= "(";
			$where .= TQL::parse(trim($matches[3][0]), $model);
			$where .= ")";
			return $where;
		}
		
		preg_match('/(.+)( AND | OR )(.+)/', $condition, $matches, PREG_OFFSET_CAPTURE);
		// print_r($matches);

		if (count($matches) > 0) {
			// echo " found matches $condition <p>";
			$where = TQL::parse(trim($matches[1][0]), $model);
			$where .= $matches[2][0];
			$where .= TQL::parse(trim($matches[3][0]), $model);
			return $where;
		}

		preg_match('/(\(*)(.+)(<>|>=|<=|!=| IS | IN | LIKE )(.+)/', $condition, $matches, PREG_OFFSET_CAPTURE);

		if (count($matches) == 0) {
			preg_match('/(\(*)(.+)(=|<|>)(.+)/', $condition, $matches, PREG_OFFSET_CAPTURE);
		}
		// print_r($matches);

		if (count($matches) > 0) {
			$optionalLeft = trim($matches[1][0]);
			// For now we only accept Field = Value format.
			// Not Value = Field
			$fieldName = trim($matches[2][0]);
			foreach ($model->fields as $field) {
				if ($field->getName() == $fieldName) {
					$fieldName = "t0." . $field->data['basisColumnDbName'];
				}
			}
			$equals = trim($matches[3][0]);
			$value = trim($matches[4][0]);
			return "$optionalLeft$fieldName $equals $value";
		}
		return $condition;
	}
}
