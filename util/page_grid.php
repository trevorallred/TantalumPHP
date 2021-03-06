<?php

/**
 * @param View $view
 */
function createGrid($view) {
	if ($view->getModel() == null) {
		return;
	}
	$modelName = $view->getModel()->getName();
	$config = new JavaScriptObject();
	$config->add("title", $view->data["label"]);
	$config->add("flex", 10);
	$config->add("stripeRows", TRUE);
	$config->add("loadMask", TRUE);
	$tbar = new JavaScriptObject();
	$tbar->add("xtype", "toolbar");
	$tbarItems = new JavaScriptArray();
	
	$tbarAdd = new JavaScriptObject();
	$tbarDelete = new JavaScriptObject();
	$tbarItems->add($tbarAdd);
	$tbarItems->add($tbarDelete);

	$tbarAdd->add("iconCls", "icon-plus");
	$tbarAdd->add("itemId", "add");
	$tbarAdd->add("text", "Add");
	$tbarAdd->addRaw("handler", "Add" . $view->getModel()->getName(). "Store");
	
	$tbarDelete->add("iconCls", "icon-minus");
	$tbarDelete->add("itemId", "delete");
	$tbarDelete->add("text", "Delete");
	$tbarDelete->addRaw("handler", "Delete" . $view->getModel()->getName(). "Store");
	
	$tbar->addRaw("items", $tbarItems);
	$config->addRaw("tbar", $tbar->printOut());
	$config->addRaw("store", $modelName . "Store");
	$config->addRaw("refresh", "function() {this.store.reload();}");
	
	if ($view->getModel()->isTop()) {
		$pagingTB = "new Ext.PagingToolbar({
			pageSize: ".$view->getModel()->data["resultsPerPage"].",
			store: ${modelName}Store
		})";
		$config->addRaw("bbar", $pagingTB);
	}

	$smFunction = "page.currentStore = ${modelName}Store; ${modelName}Store.currentRow = record; ";
	
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
	
	$afteredit = array();
	$columns = new JavaScriptArray();
	$config->add("columns", $columns);
	foreach ($view->getFields() as $field) {
		
		if ($field->data["label"] == "Table name") {
			$fieldAction = new JavaScriptObject();
			$columns->add($fieldAction);
			$fieldAction->add("xtype", "actioncolumn");
			// $fieldAction->add("header", "");
			$fieldAction->add("tooltip", "Define Table");
			$fieldAction->add("fixed", TRUE);
			$fieldAction->add("hideable", FALSE);
			$fieldAction->add("menuDisabled", TRUE);
			$fieldAction->add("sortable", FALSE);
			$fieldAction->add("resizable", FALSE);
			$fieldAction->add("width", 18);
			$fieldAction->add("icon", "ext-3.3.1/resources/images/default/toolbar/more.gif");
			$fieldAction->addRaw("handler", "function(grid, rowIndex, colIndex) {
                var rec = ${modelName}Store.getAt(rowIndex);
				Ext.Ajax.request( {
					url : 'page.php?id=e88068d5-9f57-11df-936f-e37ecc873ea2&filter=DefineTableTableID%3D%27' + rec.get('ManageTablesTableID') + '%27',
					success : function(xhr) {
						var newComponent = eval(xhr.responseText);
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
		
		$fieldJS->add("sortable", TRUE);
		//$fieldJS->add("xtype", "gridcolumn");
		// $fieldJS->add("width", 120);
		
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
						// $fieldJS->add("editor", $editor);
						// $fieldJS->add("xtype", "booleancolumn");
						// $fieldJS->add("trueText", "Yes");
						// $fieldJS->add("falseText", "No");
						break;
					case "Combo":
						break;
					default:
						$editor->add("xtype", "textfield");
						$fieldJS->add("editor", $editor);
						// $fieldJS->add("selectOnFocus", TRUE);
				}
				if ($field->data["selectorID"] > '') {
					$editor = new JavaScriptObject();
					$editor->add("lazyRender", TRUE);
					$editor->add("triggerAction", "all");
					$editor->add("mode", "remote");
					$editor->add("selectOnFocus", TRUE);
					$primaryFieldActionDetail = $field->getPrimaryFieldActionDetail();
					$fromFieldName = $primaryFieldActionDetail->data["fromFieldName"];
					$editor->add("displayField", $fromFieldName);
					$editor->add("queryParam", "query[" . $fromFieldName . "]");
					
					$storeConfig = new JavaScriptObject();
					$storeConfig->add("url", "data.php?id=" . $field->data["selectorID"]);
					$storeConfig->add("root", $field->data["selectorModelName"]);
					$storeConfigFields = new JavaScriptArray();
					foreach ($field->fieldDetails as $fieldDetail) {
						if ($fieldDetail->data["fromFieldName"] > '') {
							$storeConfigFields->add($fieldDetail->data["fromFieldName"]);
						}
					}
					$storeConfig->add("fields", $storeConfigFields);
					
					$editor->addRaw("store", "new Ext.data.JsonStore(" . $storeConfig->printOut() . ")");
					$selectFunction = "";
					foreach ($field->fieldDetails as $fieldDetail) {
						if ($fieldDetail != $primaryFieldActionDetail && $fieldDetail->data["fromFieldName"]) {
							$selectFunction .= "this.gridEditor.record.data." . $fieldDetail->data["toFieldName"] . " = record.data." . $fieldDetail->data["fromFieldName"] . "; ";
						}
					}
					
					$editor->addRaw("listeners", "{'select': function(combo, record, index) { $selectFunction }}");
					$fieldJS->addRaw("editor", "new Ext.form.ComboBox(" . $editor->printOut() . ")");
				}
			}
		}
		
		if (strlen($field->data["afteredit"]) > 0) {
			$afteredit[$field->getName()] = $field->data["afteredit"];
		}
		if (strlen($field->data["renderer"]) > 0) {
			$fieldJS->addRaw("renderer", $field->data["renderer"]);
		}
	}

	?>
	var <?php echo $view->getName() . "View" ?> = new Ext.grid.EditorGridPanel(
		<?php echo $config->printOut(); ?>
	);
	
	<?php
	if(count($afteredit) > 0) {
		echo $view->getName() . "View" ?>.addListener('afteredit', function(e) {
		<?php
		foreach ($afteredit as $key=>$value) { ?>
			if (e.field == "<?php echo $key ?>") {
				<?php echo $value ?>
				e.record.endEdit();
			}
			<?php
		}
		?>
		});
		<?php
	}
	?>
	function Position<?php echo $view->getModel()->getName() ?>StoreChange(direction) {
		var record = <?php echo $view->getModel()->getName() ?>Store.currentRow;
		if (record) {
			var index = <?php echo $view->getModel()->getName() ?>Store.indexOf(record);
			Position<?php echo $view->getModel()->getName() ?>Store(index + direction);
		}
	}
	
	function Position<?php echo $view->getModel()->getName() ?>Store(index) {
		var view = <?php echo $view->getName() ?>View;
		var store = <?php echo $view->getModel()->getName() ?>Store;
		var record = store.data.items[index];
		if (record) {
			store.currentRow = record;
			view.selModel.clearSelections();
			view.selModel.selectRow(index);
		}
	}
	
	function Delete<?php echo $view->getModel()->getName() ?>Store() {
		var rows = <?php echo $view->getName() . "View" ?>.selModel.getSelections();
		<?php echo $view->getModel()->getName() ?>Store.remove(rows);
	}

	function Add<?php echo $view->getModel()->getName() ?>Store() {
		var store = <?php echo $view->getModel()->getName() ?>Store;
		var grid = <?php echo $view->getName() ?>View;
		var obj = store.recordType;
		var o = new obj({ });
		<?php
		foreach ($view->getModel()->fields as $field) {
			$default = $field->data["defaultFieldName"];
			if (strlen($default) > 0) {
				$view->getModel()->findField($columnID);
				echo "o.data.".$field->getName()." = store.parentStore.currentRow.data.".$default."; ";
			}
			
			$default = $field->data["defaultValue"];
			if (strlen($default) > 0) {
				echo "o.data.".$field->getName()." = $default; ";
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