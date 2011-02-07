<?php
include_once '../util/tql.php';
include_once '../util/entities.php';

class TQLTest extends PHPUnit_Framework_TestCase {
	public function testBasic() {
		$modelData = array();
		$modelData["id"] = "M1";
		$modelData["name"] = "TestModel";
		$modelData["basisTableID"] = "T1";
		$modelData["basisTableDbName"] = "tan_test_model";
		$model = new Model($modelData);

		$fieldData = array();
		$fieldData["id"] = "F1";
		$fieldData["modelID"] = $modelData["id"];
		$fieldData["name"] = "TestID";
		$fieldData["basisColumnID"] = "C1";
		$fieldData["basisColumnDbName"] = "id";
		$fieldData["basisTableID"] = $modelData["basisTableID"];
		$fieldData["basisTableDbName"] = $modelData["basisTableDbName"];
		$model->fields[] = new Field($fieldData);
		
		$fieldData["id"] = "F1";
		$fieldData["name"] = "TestName";
		$fieldData["basisColumnID"] = "C2";
		$fieldData["basisColumnDbName"] = "name";
		$model->fields[] = new Field($fieldData);
		
		$this->assertEquals("t0.id = '981'",
			TQL::parse("TestID = '981'", $model));

		$this->assertEquals("(t0.id <> '981')",
			TQL::parse("(TestID <> '981')", $model));
		
		$this->assertEquals("t0.id = '981' AND t0.name != 'Foo'",
			TQL::parse("TestID = '981' AND TestName != 'Foo'", $model));

		$this->assertEquals("t0.id IN ('981') AND t0.name LIKE 'Foo%' OR t0.name > 'Bar'",
			TQL::parse("TestID IN ('981') AND TestName LIKE 'Foo%' OR TestName > 'Bar'", $model));
		
		$this->assertEquals("(t0.id < 1 OR t0.id <= 2) AND (t0.name >= 'Foo' OR t0.name = 'Bar')",
			TQL::parse("(TestID < 1 OR TestID <= 2) AND (TestName >= 'Foo' OR TestName = 'Bar')", $model));
	}
}
?>