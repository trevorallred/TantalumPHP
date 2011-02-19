<?php

/**
 * @param View $view
 */
function createGrid($view) {
	$modelName = $view->getModel()->getName();
	$config = new JavaScriptObject();
	$config->add("title", $view->data["label"]);
	$config->add("flex", 1);
	$config->add("stripeRows", TRUE);
	$columnDefaults = new JavaScriptObject();
	$columnDefaults->add("xtype", "gridcolumn");
	$columnDefaults->add("sortable", TRUE);
	$columnDefaults->add("width", 120);
	$config->add("defaults", $columnDefaults);
	$config->addRaw("store", $modelName . "Store");
	$config->addRaw("refresh", "function() {this.store.reload();}");
	
	$smFunction = "page.currentStore = ${modelName}Store;
		${modelName}Store.currentRow = record;
	";
	foreach ($view->getModel()->childModels as $childModel) {
		// TODO enhance this a bit more http://dev.sencha.com/deploy/dev/docs/source/Store.html#method-Ext.data.Store-filter
		$reference = $childModel->getParentReference();
		$from = $reference->getFromField();
		$to = $reference->getToField();
		$smFunction .= $childModel->getName()."Store.filter('".$reference->getFromField()->getName()."', record.data.".$reference->getToField()->getName()."); ";
	};
	$config->addRaw("sm", "new Ext.grid.RowSelectionModel( {
		listeners : {
			rowselect : {
				fn : function(sm, index, record) {
					$smFunction
				}
			}
		}
	})");
	
	$columns = new JavaScriptArray();
	$config->add("columns", $columns);
	foreach ($view->getFields() as $field) {
		
		if ($field->data["label"] == "Table name") {
			$fieldAction = new JavaScriptObject();
			$columns->add($fieldAction);
			$fieldAction->add("xtype", "actioncolumn");
			$fieldAction->add("sortable", FALSE);
			$fieldAction->add("resizable", FALSE);
			$fieldAction->add("width", 29);
			$fieldAction->add("icon", "themes/default/icons/zoom.png");
			$fieldAction->add("tooltip", "Open Table");
			$fieldAction->addRaw("handler", "function(grid, rowIndex, colIndex) {
                  var rec = ${modelName}Store.getAt(rowIndex);
				Ext.Ajax.request( {
					url : 'page.php?id=e88068d5-9f57-11df-936f-e37ecc873ea2',
					success : function(xhr) {
						var newComponent = eval(xhr.responseText);
						newComponent.filter(\"DefineTableTableID = '\" + rec.get('ManageTablesTableID') + \"'\");
						var contentPanel = Ext.ComponentMgr.get('contentPanel');
						contentPanel.add(newComponent);
						contentPanel.setActiveTab(newComponent);
					}
				});
            }");
		}
		
		$fieldJS = new JavaScriptObject();
		$columns->add($fieldJS);
		if ($field->data["visible"] == 0)  {
			$fieldJS->add("hidden", TRUE);
		}
		$fieldJS->add("header", $field->data["label"]);
		
		$width = 0;
		if ($field->data["size"] > 0) {
			$width = (int)$field->data["size"];
		} else {
			if ($field->data["displayType"] == "Checkbox") {
				$width = 30;
			}
		}
		$minWidth = 20 + (strlen($field->data["label"]) * 5);
		if ($width > 0 && $width < $minWidth) {
			$width = $minWidth;
		}
		if ($width > 0) {
			$fieldJS->add("width", $width);
		}
		
		$fieldJS->add("dataIndex", $field->data["name"]);
		
		if ($field->data["basisColumnType"] == "Integer") {
			$fieldJS->add("xtype", "numbercolumn");
			$fieldJS->add("format", "0");
		}
		
		if ($field->data["editable"] == 1) {
			if ($field->data["editor"]) {
				$fieldJS->addRaw("editor", $field->data["editor"]);
			} else {
				$editor = new JavaScriptObject();
				switch ($field->data["displayType"]) {
					case "Checkbox":
						$editor->add("xtype", "checkbox");
						$editor->add("align", "center");
						$fieldJS->add("editor", $editor);
						break;
					case "Combo":
						break;
					default:
						$editor->add("xtype", "textfield");
						$fieldJS->add("editor", $editor);
				}
			}
		}
		
		if (strlen($field->data["renderer"]) > 0) {
			$fieldJS->addRaw("renderer", $field->data["renderer"]);
		}
	}

	?>
	var <?php echo $view->getName() . "View" ?> = new Ext.grid.EditorGridPanel(
		<?php echo $config->printOut(); ?>
	);
	
	function Delete<?php echo $view->model->getName() ?>Store() {
		var rows = <?php echo $view->getName() . "View" ?>.selModel.getSelections();
		<?php echo $view->model->getName() ?>Store.remove(rows);
	}

	function Add<?php echo $view->model->getName() ?>Store() {
		var store = <?php echo $view->model->getName() ?>Store;
		var grid = <?php echo $view->getName() ?>View;
		var obj = store.recordType;
		var o = new obj({ });
		<?php
		foreach ($view->model->fields as $field) {
			$field_default = $field->data["defaultFieldName"];
			if (strlen($field_default) > 0) {
				$view->model->findField($columnID);
				echo "o.data.".$field->getName()." = store.parentStore.currentRow.data.".$field_default.";
				";
			}
		}
		?>
		grid.stopEditing();
		
		var size = store.data.length;
		store.insert(size, o);
	 	grid.startEditing(size, 1);
	}
	<?php
}

?>