{
<?php
echo $model->data['name'].":";

$sql = new QueryBuilder();
$sql->fromTable = $model->data['basisTableDbName'] . " t0";
foreach ($model->fields as $column) {
	$sql->addField("t0." . $column->data['basisColumnDbName'] . " AS " . $column->data['name']);
}

$rows = $db->select($sql->sql());

echo HtmlUtils::jsonEncode($rows);
?>
}
